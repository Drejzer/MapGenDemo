extends "res://addons/MapGenTools/_WorldMetaLayer.gd"

func Generate():
	map=[]
	
	var par = get_parent()
	var tm = par.get_node("TemperatureMap")
	var rfm= par.get_node("RainfallMap")
	var hm = par.get_node("HeightMap")
	
	world_x_size=get_parent().world_x_size
	world_y_size=get_parent().world_y_size
	
	
	
	var osn = OpenSimplexNoise.new()
	osn.set_seed(layer_seed)
	osn.lacunarity = lacun
	osn.period = period
	osn.persistence = persist
	osn.octaves = octaves
	#print("$",layer_seed,"?=",osn.get_seed())
	
	var radius = float(world_x_size)/(2.0*PI)
	
	for x in range(world_x_size):
		var deg = float(float(x)/float(world_x_size))*2*PI+rotation
		map.append([])
	
		for y in range(world_y_size):
			var tmp_grad=(float(y)/float(world_y_size))*PI
			var noiseval = osn.get_noise_3d(cos(deg)*radius+offset.x,sin(deg)*radius+offset.y,y+offset.z)
			noiseval=clamp(0.15*noiseval+0.35*tm.map[x][y]+0.5*rfm.map[x][y],0.0,2.0)
			
			if tm.map[x][y]<=par.IcebergThershold+0.001 or hm.map[x][y]>=1.0-(1.0-par.MountainThreshold)*0.75 or hm.map[x][y]<=par.SeaLevel-0.0025:
				noiseval=0
			map[x].append(noiseval)

