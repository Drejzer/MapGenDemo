extends Node

onready var walk:=get_node("Walker")
onready var opt: =get_node("Control/Options")
onready var wld:=get_node("World")
onready var tmd:=get_node("TemperatureDisplay")
onready var bd:=get_node("BiomeDisplay")
onready var rfd:=get_node("RainfallDisplay")
onready var trd:=get_node("TerrainDisplay")
onready var vgd:=get_node("VegetationDisplay")
onready var drd:=get_node("DrainageDisplay")

func _on_Options_ui_generate_pressed() -> void:
	wld.isCreated=false
	seed(wld.world_seed)
	yield(get_tree(),"idle_frame")
	yield(get_tree(),"idle_frame")
	wld.call_deferred("make_world",1)
	yield(wld,"data_created")
	tmd._gen_Temperature_disp()
	yield(get_tree(),"idle_frame")
	trd._generate_Terrain_map()
	yield(get_tree(),"idle_frame")
	rfd._gen_Biome_disp()
	yield(get_tree(),"idle_frame")
	vgd._gen_Vege_disp()
	yield(get_tree(),"idle_frame")
	bd._gen_Biome_disp()
	yield(get_tree(),"idle_frame")
	drd._gen_Drain_disp()
	yield(get_tree(),"idle_frame")
	walk._on_HeightMap_ready()
	yield(get_tree(),"idle_frame")
	wld.isCreated=true
	yield(get_tree(),"idle_frame")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("SwitchBiomeDisp"):
		bd.visible=!bd.visible
		get_tree().set_input_as_handled()
	elif event.is_action_pressed("SwitchToHeightDisp"):
		trd.visible=true
		tmd.visible=false
		rfd.visible=false
		vgd.visible=false
		drd.visible=false
		get_tree().set_input_as_handled()
	elif event.is_action_pressed("SwitchToRainDisp"):
		rfd.visible=true
		tmd.visible=false
		trd.visible=false
		vgd.visible=false
		drd.visible=false
		get_tree().set_input_as_handled()
	elif event.is_action_pressed("SwitchToVegeDisp"):
		vgd.visible=true
		rfd.visible=false
		tmd.visible=false
		trd.visible=false
		drd.visible=false
		get_tree().set_input_as_handled()
	elif event.is_action_pressed("SwitchToDrainageDisp"):
		drd.visible=true
		tmd.visible=false
		vgd.visible=false
		rfd.visible=false
		trd.visible=false
	elif event.is_action_pressed("SwitchToTempDisp"):
		tmd.visible=true
		drd.visible=false
		vgd.visible=false
		rfd.visible=false
		trd.visible=false
		get_tree().set_input_as_handled()
	
	
