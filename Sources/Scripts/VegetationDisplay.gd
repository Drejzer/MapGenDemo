extends TileMap

onready var wld:=get_node("../World")
onready var vege:=get_node("../World/VegetationMap")



signal Generated

func _gen_Vege_disp():
	for i in range(-wld.world_x_size/2,3*wld.world_x_size/2):
		for j in range(wld.world_y_size):
			var tp = vege.map[(wld.world_x_size+i)%wld.world_x_size][j]
			if tp < 0.125:
				self.set_cell(i,j,0)
			elif tp <= 0.25:
				self.set_cell(i,j,1)
			elif tp <= 0.375:
				self.set_cell(i,j,2)
			elif tp <= 0.5:
				self.set_cell(i,j,3)
			elif tp <= 0.625:
				self.set_cell(i,j,4)
			elif tp <= 0.75:
				self.set_cell(i,j,5)
			elif tp <= 0.875:
				self.set_cell(i,j,6)
			else:
				self.set_cell(i,j,7)
	emit_signal("Generated")

