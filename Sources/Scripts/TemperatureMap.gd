extends "res://addons/MapGenTools/_WorldMetaLayer.gd"

onready var wld:=get_parent()

func Generate(_args):
	GenerateTemperatureMap()

func GenerateTemperatureMap():
	var TemperatureHigh=wld.TemperatureHigh
	var TemperatureLow=wld.TemperatureLow
	map=[]
	
	world_x_size=get_parent().world_x_size
	world_y_size=get_parent().world_y_size
	#layer_seed=get_parent().layer_seed
	
	
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
			var noiseval = (TemperatureHigh-TemperatureLow)*((osn.get_noise_3d(cos(deg)*radius+offset.x,sin(deg)*radius+offset.y,y+offset.z)+0.90)/1.80)+TemperatureLow
			#map[x].append((TemperatureHigh-TemperatureLow)*(0.75*(sin(tmp_grad)*sin(tmp_grad))+0.25*abs(noiseval)*sin(-PI/2.0+tmp_grad*2))+TemperatureLow)
			map[x].append((sin(tmp_grad)*sin(tmp_grad)*TemperatureHigh+TemperatureLow*cos(tmp_grad)*cos(tmp_grad))*0.8+0.3*noiseval*(abs(cos(tmp_grad*2.0))/2.0+0.6))
