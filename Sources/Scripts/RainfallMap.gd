extends "res://addons/MapGenTools/_WorldMetaLayer.gd"

onready var par: = get_parent()

func Generate(args):
	map=[]
	
	world_x_size=par.world_x_size
	world_y_size=par.world_y_size
	
	var osn = OpenSimplexNoise.new()
	osn.set_seed(layer_seed)
	osn.period = period
	osn.lacunarity = lacun
	osn.persistence = persist
	osn.octaves = octaves
	
	var radius = float(world_x_size)/(2.0*PI)
	
	for x in range(world_x_size):
		var deg = float(float(x)/float(world_x_size))*2*PI+rotation
		map.append([])
		for y in range(world_y_size):
			var noiseval = (osn.get_noise_3d(cos(deg)*radius+offset.x,sin(deg)*radius+offset.y,y+offset.z)/0.86+1.0)/2.0
			map[x].append((noiseval*noiseval))
