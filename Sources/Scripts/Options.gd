extends "res://Sources/Scripts/UserInterface.gd"

onready var world:=get_node("../../World")


func _on_Randomise_pressed() -> void:
	var rng:=RandomNumberGenerator.new()
	rng.randomize()
	var rseed = rng.randi()
	rng.set_seed(rseed)
	
	var rval=rseed
	
	values["WorldSeed"]=rval;
	get_node("PauseMenu/TabContainer/World/WorldSeed/Value").value=rval
	world.world_seed=rval
	
	rval=rng.randi()
	values["TerrainSeed"]=rval
	get_node("PauseMenu/TabContainer/Terrain/TerrainSeed/Value").value=rval
	world.primaryLayers[0].layer_seed=rval
	
	rval=rng.randi()
	values["RainfallSeed"]=rval
	get_node("PauseMenu/TabContainer/Rainfall/RainfallSeed/Value").value=rval
	world.primaryLayers[1].layer_seed=rval
	
	rval=rng.randi()
	values["TemperatureSeed"]=rval
	get_node("PauseMenu/TabContainer/Temperature/TemperatureSeed/Value").value=rval
	world.primaryLayers[2].layer_seed=rval
	
	rval=rng.randi()
	values["DrainageSeed"]=rval
	get_node("PauseMenu/TabContainer/Drainage/DrainageSeed/Value").value=rval
	world.primaryLayers[3].layer_seed=rval
	
	rval=rng.randi()
	values["RiverSeed"]=rval
	get_node("PauseMenu/TabContainer/Rivers/RiverSeed/Value").value=rval
	world.secondaryLayers[0].layer_seed=rval
	
	rval=rng.randi()
	values["VegetationSeed"]=rval
	get_node("PauseMenu/TabContainer/Vegetation/VegetationSeed/Value").value=rval
	world.secondaryLayers[1].layer_seed=rval
	
	rval=rng.randi()
	world.secondaryLayers[2].layer_seed=rval

