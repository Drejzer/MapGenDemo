extends TileMap

onready var terr:=get_node("../World/HeightMap")
onready var height:=get_node("../World/HeightMap")
onready var riv:=get_node("../World/RiverMap")

signal Generated

func _generate_Terrain_map() -> void:
	clear()
	for i in range(terr.world_x_size):
		for j in range(terr.world_y_size):
			var hpoint = terr.map[i][j]
			if hpoint <= -0.2:
				self.set_cell(i,j,0)
			elif hpoint <= -0.1:
				self.set_cell(i,j,1)
			elif hpoint <= 0.0:
				self.set_cell(i,j,1)
			elif hpoint <= 0.100:
				self.set_cell(i,j,3)
			elif hpoint <= 0.2:
				self.set_cell(i,j,4)
			elif hpoint <= 0.3:
				self.set_cell(i,j,5)
			elif hpoint <= 0.4:
				self.set_cell(i,j,6)
			elif hpoint <= 0.5:
				self.set_cell(i,j,7)
			elif hpoint <= 0.6:
				self.set_cell(i,j,8)
			elif hpoint <= 0.7:
				self.set_cell(i,j,9)
			else:
				self.set_cell(i,j,10)
			if riv.map[i][j]>0:
				self.set_cell(i,j,2)

	emit_signal("Generated")

