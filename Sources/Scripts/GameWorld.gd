extends Node2D

export var world_seed:int
export var world_x_size:int
export var world_y_size:int
export var world_name:String

export var IcebergThershold=-0.6
export var SeaLevel=0.0
export var MountainThreshold=0.6
export var ForestThreshold=0.5
export var TemperatureHigh:float=30.0
export var TemperatureLow:float=-30.0
export var RiverCount=1

var rng

export var primaryLayers=[]
export var secondaryLayers=[]

func _ready() -> void:
	rng=RandomNumberGenerator.new()
	rng.seed=world_seed
	primaryLayers.append(get_node("HeightMap"))
	primaryLayers.append(get_node("RainfallMap"))
	primaryLayers.append(get_node("DrainageMap"))
	primaryLayers.append(get_node("TemperatureMap"))
	secondaryLayers.append(get_node("RiverMap"))
	secondaryLayers.append(get_node("VegetationMap"))
	secondaryLayers.append(get_node("BiomeMap"))


	#SaveWorld()
	

func SaveWorld():
	var file=File.new()
	file.open("user://"+world_name,File.WRITE)
	#file.store_line(JSON.print(self))
	file.close()


