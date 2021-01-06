extends "res://addons/MapGenTools/_WorldMetaLayer.gd"

export var offset:Vector3=Vector3(100.0,50.0,0.0)
export var lacun=2.0
export var period=200.0
export var persist=0.5
export var octaves=2
export var rotation=2*PI


func Generate():
	
	map=[]
	
	world_x_size=get_parent().world_x_size
	world_y_size=get_parent().world_y_size
	#world_seed=get_parent().world_seed
	
	
	var osn = OpenSimplexNoise.new()
	osn.set_seed(world_seed)
	osn.lacunarity = lacun
	osn.period = period
	osn.persistence = persist
	osn.octaves = octaves
	#print("$",world_seed,"?=",osn.get_seed())
	
	var radius = float(world_x_size)/(2.0*PI)
	
	for x in range(world_x_size):
		var deg = float(float(x)/float(world_x_size))*2*PI+rotation
		map.append([])
	
		for y in range(world_y_size):
			var tmp_grad=(float(y)/float(world_y_size))*PI
			var noiseval = osn.get_noise_3d(cos(deg)*radius+offset.x,sin(deg)*radius+offset.y,y+offset.z)
			map[x].append((noiseval)*35.0)
