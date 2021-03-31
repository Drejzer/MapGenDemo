extends "res://Sources/Scripts/UserInterface.gd"

onready var world:=get_node("../../World")


func _on_Randomise_pressed() -> void:
	
	randomize()
	var rval=randi()
	
	values["WorldSeed"]=rval;
	get_node("PauseMenu/TabContainer/World/WorldSeed/Value").value=rval
	world.world_seed=rval
	
	randomize()
	rval=randi()
	values["TerrainSeed"]=rval
	get_node("PauseMenu/TabContainer/Terrain/TerrainSeed/Value").value=rval
	world.primaryLayers[0].layer_seed=rval
	
	randomize()
	rval=randi()
	values["RainfallSeed"]=rval
	get_node("PauseMenu/TabContainer/Rainfall/RainfallSeed/Value").value=rval
	world.primaryLayers[1].layer_seed=rval
	
	randomize()
	rval=randi()
	values["TemperatureSeed"]=rval
	get_node("PauseMenu/TabContainer/Temperature/TemperatureSeed/Value").value=rval
	world.primaryLayers[2].layer_seed=rval
	
	randomize()
	rval=randi()
	values["DrainageSeed"]=rval
	get_node("PauseMenu/TabContainer/Drainage/DrainageSeed/Value").value=rval
	world.primaryLayers[3].layer_seed=rval
	
	randomize()
	rval=randi()
	values["RiverSeed"]=rval
	get_node("PauseMenu/TabContainer/Rivers/RiverSeed/Value").value=rval
	world.secondaryLayers[0].layer_seed=rval
	
	randomize()
	rval=randi()
	values["VegetationSeed"]=rval
	get_node("PauseMenu/TabContainer/Vegetation/VegetationSeed/Value").value=rval
	world.secondaryLayers[1].layer_seed=rval

	randomize()
	rval=randi()
	world.secondaryLayers[2].layer_seed=rval

