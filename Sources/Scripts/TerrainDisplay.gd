extends TileMap

onready var terr:=get_node("../World/HeightMap")
onready var w:=get_node("../World")
onready var height:=get_node("../World/HeightMap")
onready var riv:=get_node("../World/RiverMap")

signal Generated

func _generate_Terrain_map() -> void:
	clear()
	for i in range(-terr.world_x_size/2,3*terr.world_x_size/2):
		for j in range(terr.world_y_size):
			var hpoint = terr.map[(i+terr.world_x_size)%terr.world_x_size][j]
			if hpoint <= w.SeaLevel-0.125:
				self.set_cell(i,j,0)
			elif hpoint <= w.SeaLevel:
				self.set_cell(i,j,1)
			elif hpoint <= w.SeaLevel*0.85+w.MountainThreshold*0.15:
				self.set_cell(i,j,3)
			elif hpoint <= w.SeaLevel*0.7+w.MountainThreshold*0.3:
				self.set_cell(i,j,4)
			elif hpoint <= w.SeaLevel*0.55+w.MountainThreshold*0.45:
				self.set_cell(i,j,5)
			elif hpoint <= w.SeaLevel*0.4+w.MountainThreshold*0.6:
				self.set_cell(i,j,6)
			elif hpoint <= w.SeaLevel*0.35+w.MountainThreshold*0.75:
				self.set_cell(i,j,7)
			elif hpoint <= w.SeaLevel*0.1+w.MountainThreshold*0.9:
				self.set_cell(i,j,8)
			elif hpoint <= w.MountainThreshold*0.75+1.0*0.25:
				self.set_cell(i,j,9)
			elif hpoint <= w.MountainThreshold*0.5+1.0*0.5:
				self.set_cell(i,j,10)
			else:
				self.set_cell(i,j,11)
			if riv.map[(terr.world_x_size+i)%terr.world_x_size][j]>0:
				self.set_cell(i,j,2)

	emit_signal("Generated")

