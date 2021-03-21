extends Node

onready var cam: =get_node("Camera2D")
onready var opt: =get_node("Control/Options")
onready var wld:=get_node("World")
		


func _on_Options_ui_generate_pressed() -> void:
	wld.isCreated=false
	var thr :=Thread.new()
	thr.start(wld,"make_world")
