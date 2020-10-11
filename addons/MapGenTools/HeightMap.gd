tool
extends EditorPlugin
func _enter_tree():
	add_custom_type("HeightMap","Node",preload("_HeightMap.gd"),preload("icon.png"))

func _exit_tree():
	remove_custom_type("HeightMap")
