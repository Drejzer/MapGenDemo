extends Node2D

export var world_seed:int
export var world_x_size:int
export var world_y_size:int
export var world_name:String


export var terrain_mode=0 #0=perlin, 1=DS, 2=fault

export var layers=[]

func _ready() -> void:
	layers.append(get_node("HeightMap"))
	layers.append(get_node("HumidityMap"))
	layers.append(get_node("TemperatureMap"))
	layers.append(get_node("VegetationMap"))


	#SaveWorld()
	

func SaveWorld():
	var file=File.new()
	file.open("user://"+world_name,File.WRITE)
	#file.store_line(JSON.print(self))
	file.close()
