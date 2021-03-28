extends TileMap

onready var wld:=get_node("../World")
onready var rain:=get_node("../World/RainfallMap")


signal Generated

func _gen_Biome_disp():
	for i in range(-wld.world_x_size/2,3*wld.world_x_size/2):
		for j in range(wld.world_y_size):
			var tp = rain.map[(wld.world_x_size+i)%wld.world_x_size][j]
			if tp <= 0.1:
				self.set_cell(i,j,0)
			elif tp <= 0.2:
				self.set_cell(i,j,1)
			elif tp <= 0.3:
				self.set_cell(i,j,2)
			elif tp <= 0.4:
				self.set_cell(i,j,3)
			elif tp <= 0.5:
				self.set_cell(i,j,4)
			elif tp <= 0.6:
				self.set_cell(i,j,5)
			elif tp <= 0.7:
				self.set_cell(i,j,6)
			elif tp <= 0.8:
				self.set_cell(i,j,7)
			elif tp <= 0.9:
				self.set_cell(i,j,8)
			else:
				self.set_cell(i,j,9)
	emit_signal("Generated")

