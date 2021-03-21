extends "res://Sources/Scripts/GameWorld.gd"

export var isCreated:=false setget set_iscreated

onready	var settings:=get_node("../Control/Options")

func set_iscreated(value:bool):
	isCreated=value
	get_node("../CanvasLayer/ColorRect").visible=!value

func make_world(arg):
	self.isCreated=false
	
	world_name=settings.values["WorldName"]
	world_x_size=settings.values["WorldWidth"]
	world_y_size=settings.values["WorldHeight"]
	
	RiverCount=settings.values["Rivercount"]
	IcebergThershold=settings.values["IceThreshold"]
	ForestThreshold=settings.values["ForestThreshold"]
	MountainThreshold=settings.values["MountainThreshold"]
	SeaLevel=settings.values["SeaLevel"]
	TemperatureHigh=settings.values["TemperatureHigh"]
	TemperatureLow=settings.values["TemperatureLow"]
	
	primaryLayers[0].layer_seed=settings.values["TerrainSeed"]
	primaryLayers[0].offset=Vector3(settings.values["TerrainXOffset"],settings.values["TerrainYOffset"],settings.values["TerrainZOffset"])
	primaryLayers[0].lacun=settings.values["TerrainLacunarity"]
	primaryLayers[0].persist=settings.values["TerrainPersistance"]
	primaryLayers[0].period=settings.values["TerrainPeriod"]
	primaryLayers[0].octaves=settings.values["TerrainOctaves"]
	
	primaryLayers[1].layer_seed=settings.values["RainfallSeed"]
	primaryLayers[1].offset=Vector3(settings.values["RainfallXOffset"],settings.values["RainfallYOffset"],settings.values["RainfallZOffset"])
	primaryLayers[1].lacun=settings.values["RainfallLacunarity"]
	primaryLayers[1].persist=settings.values["RainfallPersistance"]
	primaryLayers[1].period=settings.values["RainfallPeriod"]
	primaryLayers[1].octaves=settings.values["RainfallOctaves"]
	
	primaryLayers[2].layer_seed=settings.values["TemperatureSeed"]
	primaryLayers[2].offset=Vector3(settings.values["TemperatureXOffset"],settings.values["TemperatureYOffset"],settings.values["TemperatureZOffset"])
	primaryLayers[2].lacun=settings.values["TemperatureLacunarity"]
	primaryLayers[2].persist=settings.values["TemperaturePersistance"]
	primaryLayers[2].period=settings.values["TemperaturePeriod"]
	primaryLayers[2].octaves=settings.values["TemperatureOctaves"]
	
	primaryLayers[3].layer_seed=settings.values["DrainageSeed"]
	primaryLayers[3].offset=Vector3(settings.values["DrainageXOffset"],settings.values["DrainageYOffset"],settings.values["DrainageZOffset"])
	primaryLayers[3].lacun=settings.values["DrainageLacunarity"]
	primaryLayers[3].persist=settings.values["DrainagePersistance"]
	primaryLayers[3].period=settings.values["DrainagePeriod"]
	primaryLayers[3].octaves=settings.values["DrainageOctaves"]
	
	secondaryLayers[0].layer_seed=settings.values["RiverSeed"]
	secondaryLayers[0].river_source_Height=settings.values["RiverSH"]
	secondaryLayers[0].river_source_Rain=settings.values["RiverSR"]
	
	secondaryLayers[1].layer_seed=settings.values["VegetationSeed"]
	secondaryLayers[1].offset=Vector3(settings.values["VegetationXOffset"],settings.values["VegetationYOffset"],settings.values["VegetationZOffset"])
	secondaryLayers[1].lacun=settings.values["VegetationLacunarity"]
	secondaryLayers[1].persist=settings.values["VegetationPersistance"]
	secondaryLayers[1].period=settings.values["VegetationPeriod"]
	secondaryLayers[1].octaves=settings.values["VegetationOctaves"]
	
	var thrs=[]
	for l in range(primaryLayers.size()):
		primaryLayers[l].world_x_size = world_x_size
		primaryLayers[l].world_y_size = world_y_size
		var t:=Thread.new()
		thrs.append(t)
		t.start(primaryLayers[l],"Generate")
	
	for t in thrs:
		t.wait_to_finish()
	
	for l in range(secondaryLayers.size()):
		secondaryLayers[l].world_x_size = world_x_size
		secondaryLayers[l].world_y_size = world_y_size
		secondaryLayers[l].Generate([])
	self.isCreated=true
