extends "res://Sources/Scripts/GameWorld.gd"



func make_world(args=[400]):
	world_name="World@"+String(OS.get_time())
	rng.seed=world_seed
	print(world_seed," ",rng.seed)
	primaryLayers[0].layer_seed=rng.randi()
	primaryLayers[0].GenerateCylindricHeightMap_OpenSimplex(args[0],Vector3(-1,15,-10),2.0,0.5,128.0,4)
	world_x_size=primaryLayers[0].world_x_size
	world_y_size=primaryLayers[0].world_y_size
	for l in range(primaryLayers.size()):
		print("Generating ", primaryLayers[l].name)
		if l>0:
			primaryLayers[l].layer_seed = rng.randi()
			primaryLayers[l].world_x_size = world_x_size
			primaryLayers[l].world_y_size = world_y_size
			primaryLayers[l].Generate()
	for l in range(secondaryLayers.size()):
		print("Generating ",secondaryLayers[l].name)
		secondaryLayers[l].layer_seed = rng.randi()
		secondaryLayers[l].world_x_size = world_x_size
		secondaryLayers[l].world_y_size = world_y_size
		secondaryLayers[l].Generate()
