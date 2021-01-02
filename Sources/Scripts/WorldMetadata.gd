extends "res://Sources/Scripts/GameWorld.gd"

func make_world(args=[600]):
	world_name="World@"+String(OS.get_time())
	layers[0].world_seed=world_seed
	print(world_seed)
	#layers[0].GenerateHeightMap_plasma(8,1.1,1.0)
	layers[0].GenerateCylindricHeightMap_OpenSimplex(args[0],Vector3(0,0,0),30.0,2.0,0.55,160.0,5)
	world_x_size=layers[0].world_x_size
	world_y_size=layers[0].world_y_size
	for l in range(layers.size()):
		if l>0:
			layers[l].world_seed = world_seed
			layers[l].world_x_size = world_x_size
			layers[l].world_y_size = world_y_size
			layers[l].Generate()
