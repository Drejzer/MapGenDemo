extends "res://addons/MapGenTools/_WorldMetaLayer.gd"

func Generate():
	map=[]
	
	var rng = RandomNumberGenerator.new()
	
	var w=get_parent()
	var ht=get_parent().get_node("HeightMap")
	var rf=get_parent().get_node("RainfallMap")
	var tm=get_parent().get_node("TemperatureMap")
	var vg=get_parent().get_node("VegetationMap")
	var rv=get_parent().get_node("RiverMap")
	var dr=get_parent().get_node("DrainageMap")

	for x in range(world_x_size):
		map.append([])
		for y in range(world_y_size):
			map[x].append(0)
			if tm.map[x][y]<w.IcebergThershold: 
				map[x][y]=0 #Great Ice, poles and the like
			elif ht.map[x][y]<w.SeaLevel-0.0125:
				map[x][y]=1 # deeper oceans
			elif ht.map[x][y]<w.SeaLevel:
				map[x][y]=2 # coastal waters
			elif ht.map[x][y]>w.MountainThreshold:
				if vg.map[x][y]>1.0:
					map[x][y]=3 #mountain Forest
				elif vg.map[x][y]>0.2:
					map[x][y]=4 #grassy mountain
				else:
					map[x][y]=5 # bare mountains
			elif vg.map[x][y]<0.1:
				map[x][y]=6 #desert
			elif vg.map[x][y]<0.75:
				if rf.map[x][y]>0.5:
					if dr.map[x][y]<0.3:
						map[x][y]=7 #marshes
				else:
					map[x][y]=8#grasslands
			elif vg.map[x][y]<1.1:
				map[x][y]=9#light forest
			elif vg.map[x][y]<1.5:
				map[x][y]=10#dense forest
			elif vg.map[x][y]>=1.5:
				map[x][y]=11#jungle
