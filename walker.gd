extends Sprite

var barrier_x:int;var barrier_y:int
var speed = 10.0;
var speedmod= 1.0
	
func _process(delta: float):
	if Input.is_key_pressed(KEY_LEFT):
		if self.position.x>0:
			self.position.x-=speed*speedmod
	if Input.is_key_pressed(KEY_RIGHT):
		if self.position.x < barrier_x:
			self.position.x+=speed*speedmod
	if Input.is_key_pressed(KEY_UP):
		if self.position.y>0:
			self.position.y-=speed*speedmod
	if Input.is_key_pressed(KEY_DOWN):
		if self.position.y<barrier_y:
			self.position.y+=speed*speedmod
	if Input.is_key_pressed(KEY_Z):
		get_child(0).zoom=Vector2(get_child(0).zoom.x-0.01,get_child(0).zoom.y-0.01)
	if Input.is_key_pressed(KEY_X):
		get_child(0).zoom=Vector2(get_child(0).zoom.x+0.01,get_child(0).zoom.y+0.01)
	if Input.is_key_pressed(KEY_S):
		speed=10
	if Input.is_key_pressed(KEY_F):
		speed+=0.5
	

func _on_HeightMap_ready() -> void:
	var tmp = get_parent().get_child(0)
	barrier_x = tmp.map_x_size*8
	barrier_y = tmp.map_y_size*8
	position= Vector2(0,0)
	print(barrier_x,barrier_y)
