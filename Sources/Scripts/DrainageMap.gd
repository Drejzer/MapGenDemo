extends "res://addons/MapGenTools/_WorldMetaLayer.gd"


func Generate(args):
	map = []
	
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
			#var tmp_grad=(float(y)/float(world_y_size))*PI
			var noiseval = osn.get_noise_3d(cos(deg)*radius+offset.x,sin(deg)*radius+offset.y,y+offset.z)/0.9
			map[x].append((noiseval*noiseval))
