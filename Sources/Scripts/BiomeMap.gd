extends "res://addons/MapGenTools/_WorldMetaLayer.gd"

onready var w:=get_parent()
onready var ht:=get_parent().get_node("HeightMap")
onready var rf:=get_parent().get_node("RainfallMap")
onready var tm:=get_parent().get_node("TemperatureMap")
onready var vg:=get_parent().get_node("VegetationMap")
onready var rv:=get_parent().get_node("RiverMap")
onready var dr:=get_parent().get_node("DrainageMap")

func Generate(_args):
	map=[]
	
	var biome_codes={
	"Error":int(0),
	"Ice":int(1),
	"Sea":int(2),
	"Desert":int(3),
	"Grassland":int(4),#
	"Marshland":int(5),#
	"Swamp":int(6),#
	"Forest":int(7),#
	"Jungle":int(8),#
	"Tundra":int(9),#
	"MountainForest":int(10),#
	"MountainGrassland":int(11),#
	"BarrenMountain":int(12)#
	}

	for x in range(world_x_size):
		map.append([])
		for y in range(world_y_size):
			map[x].append(0)
			if tm.map[x][y]<=((w.IcebergThershold-0.01)*(w.TemperatureHigh-w.TemperatureLow)+w.TemperatureLow) && vg.map[x][y]<w.ForestThreshold:
				map[x][y]=biome_codes["Ice"]
				continue
			if ht.map[x][y]<w.SeaLevel&& tm.map[x][y]>((w.IcebergThershold-0.01)*(w.TemperatureHigh-w.TemperatureLow)+w.TemperatureLow):
				map[x][y]=biome_codes["Sea"]
				continue
			else:
				if ht.map[x][y]>=w.MountainThreshold && vg.map[x][y]>=w.ForestThreshold:
					map[x][y]=biome_codes["MountainForest"]
					continue
				if ht.map[x][y]>=w.MountainThreshold && vg.map[x][y]<w.ForestThreshold && vg.map[x][y]>=w.ForestThreshold*0.25:
					map[x][y]=biome_codes["MountainGrassland"]
					continue
				if ht.map[x][y]>=w.MountainThreshold && vg.map[x][y]<w.ForestThreshold*0.125:
					map[x][y]=biome_codes["BarrenMountain"]
					continue
				if vg.map[x][y]<0.125:
					map[x][y]=biome_codes["Desert"]
					continue
				if vg.map[x][y]>=0.125 && vg.map[x][y]<w.ForestThreshold && dr.map[x][y]>=rf.map[x][y]-0.125 && ht.map[x][y]<w.MountainThreshold:
					map[x][y]=biome_codes["Grassland"]
					continue
				if dr.map[x][y]<rf.map[x][y]-0.125 && vg.map[x][y]<w.ForestThreshold && ht.map[x][y]<w.MountainThreshold:
					map[x][y]=biome_codes["Marshland"]
					continue
				if dr.map[x][y]<rf.map[x][y]-0.125 && vg.map[x][y]>=w.ForestThreshold && ht.map[x][y]<w.MountainThreshold:
					map[x][y]=biome_codes["Swamp"]
					continue
				if dr.map[x][y]>=rf.map[x][y]-0.125 && vg.map[x][y]>=w.ForestThreshold && ht.map[x][y]<w.MountainThreshold && tm.map[x][y]<((1-w.IcebergThershold+0.01)*(w.TemperatureHigh-w.TemperatureLow)+w.TemperatureLow) && tm.map[x][y]>((w.IcebergThershold-0.01)*(w.TemperatureHigh-w.TemperatureLow)+w.TemperatureLow) :
					map[x][y]=biome_codes["Forest"]
					continue
				if tm.map[x][y]<=((w.IcebergThershold-0.01)*(w.TemperatureHigh-w.TemperatureLow)+w.TemperatureLow) && vg.map[x][y]>=w.ForestThreshold && ht.map[x][y]<w.MountainThreshold:
					map[x][y]=biome_codes["Tundra"]
					continue
				if tm.map[x][y]>=((1-w.IcebergThershold+0.01)*(w.TemperatureHigh-w.TemperatureLow)+w.TemperatureLow) && vg.map[x][y]>=w.ForestThreshold && ht.map[x][y]<w.MountainThreshold:
					map[x][y]=biome_codes["Jungle"]
					continue

