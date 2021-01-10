extends "res://addons/MapGenTools/_WorldMetaLayer.gd"

func Generate():
	map=[]
	
	var w=get_parent()
	var h=get_parent().get_node("HeightMap")
	var r=get_parent().get_node("RainfallMap")
	var t=get_parent().get_node("TemperatureMap")
	var v=get_parent().get_node("VegetationMap")

	for x in range(world_x_size):
		map.append([])
		for y in range(world_y_size):
			map[x].append([])
			if t.map[x][y]<w.IcebergThershold:
				map[x][y]=0
			else:
				if h.map[x][y]<w.SeaLevel:
					map[x][y]=2
			
