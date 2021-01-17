extends "res://addons/MapGenTools/_WorldMetaLayer.gd"

func Generate():
	map=[]
	
	var rng = RandomNumberGenerator.new()
	
	var w=get_parent()
	var ht=get_parent().get_node("HeightMap")
	var rf=get_parent().get_node("RainfallMap")
	var tm=get_parent().get_node("TemperatureMap")
	var vg=get_parent().get_node("VegetationMap")

	for x in range(world_x_size):
		map.append([])
		for y in range(world_y_size):
			map[x].append([])
			if tm.map[x][y]<w.IcebergThershold:
				map[x][y]=0
			else:
				if ht.map[x][y]<w.SeaLevel:
					map[x][y]=2
			
