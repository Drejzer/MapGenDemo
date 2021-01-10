extends "res://addons/MapGenTools/_WorldMetaLayer.gd"

func Generate():
	map=[]
	for x in range(world_x_size):
		map.push_back([])
		for y in range(world_y_size):
			map[x].push_back(0)
