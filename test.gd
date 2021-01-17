extends Node
var m
var thr=Thread.new()
var counter:int

func make_ready() -> void:
	m=get_node("WorldMetadata")
	counter=0
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	m.world_seed=rng.randi()
	m.make_world()
	var a = get_node("TileMap")
	var w=get_node("walker")
	w._on_HeightMap_ready()
	a._spit()
	

func _thr_world_gen(starttime):
	print(starttime)
	m.make_world(600,600)
	

func _savemap():
	var file=File.new()
	file.open("user://sav"+String(counter),File.WRITE)
	file.store_line(JSON.print(m.maps))
	file.close()
	

