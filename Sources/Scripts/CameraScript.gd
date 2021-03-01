extends Camera2D

var barrier_x:int;var barrier_y:int
var speed = 10.0;
var speedmod= 1.0
	
func _ready() -> void:
	position = Vector2(100,100)
	zoom=Vector2(5,5)

# warning-ignore:unused_argument
func _process(delta: float):
	if Input.is_key_pressed(KEY_LEFT):
		self.position.x=abs(int(barrier_x+1+self.position.x-speed*speedmod)%(barrier_x+1))
	if Input.is_key_pressed(KEY_RIGHT):
		self.position.x=abs(int(self.position.x+speed*speedmod)%(barrier_x+1))
	if Input.is_key_pressed(KEY_UP):
		if self.position.y>0:
			self.position.y-=speed*speedmod
	if Input.is_key_pressed(KEY_DOWN):
		if self.position.y<barrier_y:
			self.position.y+=speed*speedmod
	if Input.is_key_pressed(KEY_Z):
		self.zoom=Vector2(clamp(get_child(0).zoom.x-0.05,0.2,5.5),clamp(get_child(0).zoom.y-0.05,0.2,5.5))
	if Input.is_key_pressed(KEY_X):
		self.zoom=Vector2(clamp(get_child(0).zoom.x+0.05,0.2,5.5),clamp(get_child(0).zoom.y+0.05,0.2,5.5))
	if Input.is_key_pressed(KEY_S):
		speed=16
	if Input.is_key_pressed(KEY_F):
		speed+=8
	position=Vector2(self.position.x,clamp(self.position.y,0,barrier_y))
