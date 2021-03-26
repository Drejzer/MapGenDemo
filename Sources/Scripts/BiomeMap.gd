extends "res://addons/MapGenTools/_WorldMetaLayer.gd"

onready var w:=get_parent()
onready var ht:=get_parent().get_node("HeightMap")
onready var rf:=get_parent().get_node("RainfallMap")
onready var tm:=get_parent().get_node("TemperatureMap")
onready var vg:=get_parent().get_node("VegetationMap")
onready var rv:=get_parent().get_node("RiverMap")
onready var dr:=get_parent().get_node("DrainageMap")

func Generate(args):
	map=[]
	
	var rng = RandomNumberGenerator.new()
	

	var biome_codes={
	"Ice":0,
	"DeepSea":1,
	"Sea":2,
	"Desert":3,
	"Grassland":4,
	"Marshland":5,
	"Swamp":6,
	"Forest":7,
	"Jungle":8,
	"Tundra":9,
	"MountainForest":10,
	"MountainGrassland":11,
	"BarrenMountain":12
	}

	for x in range(world_x_size):
		map.append([])
		for y in range(world_y_size):
			map[x].append(0)
			if tm.map[x][y]<w.IcebergThershold: 
				map[x][y]=biome_codes["Ice"]
				continue
			if ht.map[x][y]<w.SeaLevel-0.01375:
				map[x][y]=biome_codes["DeepSea"]
				continue
			if ht.map[x][y]<w.SeaLevel:
				map[x][y]=biome_codes["Sea"]
				continue
			if ht.map[x][y]>w.MountainThreshold:
				if vg.map[x][y]>w.ForestThreshold:
					map[x][y]=biome_codes["MountainForest"]
				elif vg.map[x][y]>0.2:
					map[x][y]=biome_codes["MountainGrassland"] #grassy mountain
				else:
					map[x][y]=biome_codes["BarrenMountain"]
				continue
			if vg.map[x][y]<0.1:
				map[x][y]=6 #desert
			if vg.map[x][y]<w.ForestThreshold:
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
