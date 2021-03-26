extends Sprite

var barrier_x:int;var barrier_y:int
var speed = 10.0;
var speedmod= 1.0
var gensemafor=false

	
func _ready() -> void:
	position = Vector2(100,100)
	get_child(0).zoom=Vector2(5,5)

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
		get_child(0).zoom=Vector2(clamp(get_child(0).zoom.x-0.05,0.2,5.5),clamp(get_child(0).zoom.y-0.05,0.2,5.5))
	if Input.is_key_pressed(KEY_X):
		get_child(0).zoom=Vector2(clamp(get_child(0).zoom.x+0.05,0.2,5.5),clamp(get_child(0).zoom.y+0.05,0.2,5.5))
	if Input.is_key_pressed(KEY_S):
		speed=16
	if Input.is_key_pressed(KEY_F):
		speed+=8
	if Input.is_key_pressed(KEY_SPACE) && !gensemafor:
		gensemafor=true
		get_parent().make_ready()
	position=Vector2(self.position.x,clamp(self.position.y,0,barrier_y))

func _on_HeightMap_ready() -> void:
	var tmp = get_parent().get_node("World/HeightMap")
	barrier_x = (tmp.world_x_size-1)*8
	barrier_y = (tmp.world_y_size-1)*8
	var k=get_child(0)
	self.position=Vector2(tmp.world_x_size/2,tmp.world_y_size/2)
	k.limit_right=barrier_x+5
	k.limit_bottom=barrier_y+5
	k.limit_top=-1
	k.limit_left=-1
	if position.x>barrier_x:
		position.x=barrier_x-1
	elif position.x < 0:
		position.x=1
	if position.y>barrier_y:
		position.y=barrier_y-1
	elif position.y < 0:
		position.y=1
	gensemafor=false
	#print(barrier_x,barrier_y)
