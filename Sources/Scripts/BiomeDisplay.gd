extends TileMap

onready var wld:=get_node("../World")
onready var biome:=get_node("../World/BiomeMap")


signal Generated

func _gen_Biome_disp():
	for i in range(-wld.world_x_size/2,3*wld.world_x_size/2):
		for j in range(wld.world_y_size):
			self.set_cell(i,j,biome.map[(wld.world_x_size+i)%wld.world_x_size][j])
	emit_signal("Generated")
