extends TileMap

onready var wld:=get_node("../World")
onready var temper:=get_node("../World/TemperatureMap")

signal Generated

func _gen_Temperature_disp():
	for i in range(-wld.world_x_size/2,3*wld.world_x_size/2):
		for j in range(wld.world_y_size):
			var tp = temper.map[(wld.world_x_size+i)%wld.world_x_size][j]
			if tp <= wld.TemperatureHigh*0.1+wld.TemperatureLow*0.9:
				self.set_cell(i,j,0)
			elif tp <= wld.TemperatureHigh*0.20+wld.TemperatureLow*0.8:
				self.set_cell(i,j,1)
			elif tp <= wld.TemperatureHigh*0.30+wld.TemperatureLow*0.65:
				self.set_cell(i,j,3)
			elif tp <= wld.TemperatureHigh*0.40+wld.TemperatureLow*0.5:
				self.set_cell(i,j,4)
			elif tp <= wld.TemperatureHigh*0.50+wld.TemperatureLow*0.55:
				self.set_cell(i,j,5)
			elif tp <= wld.TemperatureHigh*0.60+wld.TemperatureLow*0.45:
				self.set_cell(i,j,6)
			elif tp <= wld.TemperatureHigh*0.70+wld.TemperatureLow*0.35:
				self.set_cell(i,j,7)
			elif tp <= wld.TemperatureHigh*0.80+wld.TemperatureLow*0.25:
				self.set_cell(i,j,8)
			elif tp <= wld.TemperatureHigh*0.90+wld.TemperatureLow*0.15:
				self.set_cell(i,j,9)
			else:
				self.set_cell(i,j,10)
	emit_signal("Generated")
