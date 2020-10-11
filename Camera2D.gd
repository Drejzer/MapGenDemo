extends Camera2D

func _process(delta: float):
	if Input.is_key_pressed(KEY_LEFT):
		#if !(self.position.x>0):
			self.position.x+=10
	if Input.is_key_pressed(KEY_RIGHT):
		#if !(self.position.x>get_child(1).map_x_size):
			self.position.x-=10
	if Input.is_key_pressed(KEY_UP):
		if self.position.y<0:
			self.position.y+=10
	if Input.is_key_pressed(KEY_DOWN):
		#if self.position.y<get_child(1).map_y_size:
			self.position.y-=10
