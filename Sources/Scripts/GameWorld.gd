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

var rng = RandomNumberGenerator.new()

export var layers=[]

func _ready() -> void:
	rng.randomize()
	rng.seed=world_seed
	layers.append(get_node("HeightMap"))
	layers.append(get_node("RainfallMap"))
	layers.append(get_node("TemperatureMap"))
	layers.append(get_node("VegetationMap"))
	layers.append(get_node("BiomeMap"))


	#SaveWorld()
	

func SaveWorld():
	var file=File.new()
	file.open("user://"+world_name,File.WRITE)
	#file.store_line(JSON.print(self))
	file.close()


