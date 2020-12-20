extends "res://addons/MapGenTools/_WorldMetaLayer.gd"



func GenerateTemperatureGradient(mode=0):
	world_x_size=get_parent().world_x_size
	world_y_size=get_parent().world_y_size
	world_seed=get_parent().world_seed
	
	var _temper_tmp=(float(world_y_size)-1.0)/2.0
	var _temper_edge = -_temper_tmp
	for x in range(world_x_size):
		map.append([])
		for y in range(world_y_size):
			map.append(abs(tanh(y-world_y_size/2)))
	
