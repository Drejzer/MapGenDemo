extends "res://addons/MapGenTools/_WorldMetaLayer.gd"

onready var par := get_parent()
onready var tm := get_parent().get_node("TemperatureMap")
onready var rfm:= get_parent().get_node("RainfallMap")
onready var hm := get_parent().get_node("HeightMap")
onready var rvm:= get_parent().get_node("RiverMap")
onready var drm:= get_parent().get_node("DrainageMap")


func Generate(args):
	map=[]
	
	world_x_size=get_parent().world_x_size
	world_y_size=get_parent().world_y_size
	
	var osn = OpenSimplexNoise.new()
	osn.set_seed(layer_seed)
	osn.lacunarity = lacun
	osn.period = period
	osn.persistence = persist
	osn.octaves = octaves
	
	var radius = float(world_x_size)/(2.0*PI)
	
	for x in range(world_x_size):
		var deg = float(float(x)/float(world_x_size))*2*PI+rotation
		map.append([])
		for y in range(world_y_size):
			
			var noiseval = osn.get_noise_3d(cos(deg)*radius+offset.x,sin(deg)*radius+offset.y,y+offset.z)/0.86+1.0
			noiseval=(0.5+(0.35*(tm.map[x][y]-par.TemperatureLow)/(par.TemperatureHigh-par.TemperatureLow)))*noiseval+rfm.map[x][y]*(rfm.map[x][y]-drm.map[x][y])+0.875*rfm.map[x][y]+0.25*noiseval
			
			if hm.map[x][y]>=par.MountainThreshold/2.0+0.5 or (tm.map[x][y]-par.TemperatureLow)/(par.TemperatureHigh-par.TemperatureLow)<=par.IcebergThershold*0.75:
				noiseval*=0.1
			if tm.map[x][y]>=par.TemperatureLow*0.125+par.TemperatureHigh*0.875 && rfm.map[x][y]<=0.1375:
				noiseval*=0.0125
			if hm.map[x][y]<=par.SeaLevel:
				noiseval*=0.001
			if rvm.map[x][y]<1&&rvm.map[x][y]>-1 && !rvm.map[x][y]>0:
				var rivcount=0
				for i in range(3):
						for j in range(3):
							if y-1+j<0 || y-1+j>=world_y_size:
								rivcount+=0.25
							elif rvm.map[(x+world_x_size+i-1)%world_x_size][y+j-1]>0:
								rivcount+=1
				noiseval=clamp(noiseval+0.2*rivcount,0.0,2.0)/2.0
			map[x].append(noiseval)
