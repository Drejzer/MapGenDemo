extends Node
export var map_x_size : int
export var map_y_size : int
export var map = []


func _init(x:int = 100,y:int=100):
	map_x_size=x
	map_y_size=y
	GenerateHeightMap()

func GenerateHeightMap(mode:int = 0, rng_seed:int = -6398989897141750821):
	var rng = RandomNumberGenerator.new()
	rng.seed=rng_seed
	match mode:
		1:
			for i in range(map_y_size):
				map.append([])
				for _j in range(map_x_size):
					map[i].append(30.0)
		_:#panic breakout, pure randomness 
			for i in range(map_y_size):
				map.append([])
				for _j in range(map_x_size):
					map[i].append(rng.randfn(33.3,40.4))
					

func _ready():
	self._init(1000,1000)
	var tilemap = get_child(0)
	for i in range(map_x_size):
		for j in range(map_y_size):
			var hpoint = map[i][j]
			if hpoint < 0.0:
				tilemap.set_cell(i,j,0)
			elif hpoint <= 20.0:
				tilemap.set_cell(i,j,1)
			elif hpoint <= 40.0:
				tilemap.set_cell(i,j,2)
			elif hpoint <= 60.0:
				tilemap.set_cell(i,j,3)
			elif hpoint <= 80:
				tilemap.set_cell(i,j,4)
			elif hpoint <= 100.0:
				tilemap.set_cell(i,j,5)
			elif hpoint <= 120.0:
				tilemap.set_cell(i,j,6)
			else:
				tilemap.set_cell(i,j,7)
	emit_signal("ready")

