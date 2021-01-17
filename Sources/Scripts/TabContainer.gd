extends TabContainer

var _world

func _ready() -> void:
	_world=get_parent().get_parent().get_node("World")
