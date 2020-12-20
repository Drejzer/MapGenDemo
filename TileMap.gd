extends TileMap

func _spit() -> void:
	clear()
	var par = get_parent().get_node("WorldMetadata/HeightMap")
	for i in range(par.world_x_size):
		for j in range(par.world_y_size):
			var hpoint = par.map[i][j]
			if hpoint <= -0.25:
				self.set_cell(i,j,0)
			elif hpoint <= -0.05:
				self.set_cell(i,j,1)
			elif hpoint <= 0.025:
				self.set_cell(i,j,4)
			elif hpoint <= 0.2:
				self.set_cell(i,j,5)
			elif hpoint <= 0.375:
				self.set_cell(i,j,6)
			elif hpoint <= 0.55:
				self.set_cell(i,j,7)
			elif hpoint <= 0.725:
				self.set_cell(i,j,8)
			elif hpoint <= 0.875:
				self.set_cell(i,j,9)
			else:
				self.set_cell(i,j,10)
