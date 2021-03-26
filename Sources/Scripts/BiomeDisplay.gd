extends TileMap

onready var wld:=get_node("../World")
onready var biome:=get_node("../World/BiomeMap")


signal Generated

func _gen_Biome_disp():
	for i in range(wld.world_x_size):
		for j in range(wld.world_y_size):
			self.set_cell(i,j,biome.map[i][j])
	emit_signal("Generated")
