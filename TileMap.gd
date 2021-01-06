extends TileMap

func _spit() -> void:
	clear()
	var par = get_parent().get_node("WorldMetadata/RainfallMap")
	for i in range(par.world_x_size):
		for j in range(par.world_y_size):
			var hpoint = par.map[i][j]
			if hpoint <= -20.0:
				self.set_cell(i,j,0)
			elif hpoint <= -15.0:
				self.set_cell(i,j,1)
			elif hpoint <= -10.0:
				self.set_cell(i,j,2)
			elif hpoint <= -5.0:
				self.set_cell(i,j,3)
			elif hpoint <= 0.0:
				self.set_cell(i,j,4)
			elif hpoint <= 5.0:
				self.set_cell(i,j,5)
			elif hpoint <= 10.0:
				self.set_cell(i,j,6)
			elif hpoint <= 15.0:
				self.set_cell(i,j,7)
			elif hpoint <= 20.0:
				self.set_cell(i,j,8)
			elif hpoint <= 25.0:
				self.set_cell(i,j,9)
			else:
				self.set_cell(i,j,10)
