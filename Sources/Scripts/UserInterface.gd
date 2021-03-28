extends Control

onready var scenetree:=get_tree()
onready var menu:=get_node("PauseMenu")
signal ui_generate_pressed

export var values:={
			"WorldName":"World",
			"WorldSeed":0,
			"WorldWidth":600,
			"WorldHeight":400,
			"Rivercount":16,
			"SeaLevel":0.0,
			"MountainThreshold":0.7,
			"IceThreshold":0.125,
			"ForestThreshold":0.75,
			"TemperatureHigh":30.0,
			"TemperatureLow":-30.0,
			"TerrainSeed":0,
			"TerrainXOffset":0,
			"TerrainYOffset":0,
			"TerrainZOffset":0,
			"TerrainLacunarity":2.0,
			"TerrainPersistance":0.5,
			"TerrainPeriod":64.0,
			"TerrainOctaves":4,
			"RainfallSeed":0,
			"RainfallXOffset":0,
			"RainfallYOffset":0,
			"RainfallZOffset":0,
			"RainfallLacunarity":1.0,
			"RainfallPersistance":0.5,
			"RainfallPeriod":100.0,
			"RainfallOctaves":2,
			"TemperatureSeed":0,
			"TemperatureXOffset":0,
			"TemperatureYOffset":0,
			"TemperatureZOffset":0,
			"TemperatureLacunarity":1.0,
			"TemperaturePersistance":0.5,
			"TemperaturePeriod":200.0,
			"TemperatureOctaves":2,
			"DrainageSeed":0,
			"DrainageXOffset":0,
			"DrainageYOffset":0,
			"DrainageZOffset":0,
			"DrainageLacunarity":1.0,
			"DrainagePersistance":0.95,
			"DrainagePeriod":100.0,
			"DrainageOctaves":3,
			"RiverSeed":0,
			"RiverSR":0.75,
			"RiverSH":0.69,
			"VegetationSeed":0,
			"VegetationXOffset":0,
			"VegetationYOffset":0,
			"VegetationZOffset":0,
			"VegetationLacunarity":1.0,
			"VegetationPersistance":1,
			"VegetationPeriod":100.0,
			"VegetationOctaves":3,
			}

var paused: = false setget set_paused

func set_paused(value:bool):
	paused=value
	scenetree.paused=value
	menu.visible=value
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause"):
		self.paused=!paused
		scenetree.set_input_as_handled()


func _on_Generate_pressed() -> void:
	self.paused=false
	emit_signal("ui_generate_pressed")

func _on_value_changed(val,valname:String) -> void:
	values[valname]=val
	


func _on_Quit_pressed():
	get_tree().quit()


func _on_Randomise_pressed() -> void:
	pass # Replace with function body.
