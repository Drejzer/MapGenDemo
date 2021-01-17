extends "res://addons/MapGenTools/_WorldMetaLayer.gd"

export var rivers=[]
var astar = AStar.new()
var seapoints=[]

var rng=RandomNumberGenerator.new()
var par=get_parent()
var terr
	
func _ready() -> void:
	terr =get_parent().get_node("HeightMap")
	par=get_parent()
func RiverSource_fromVector(point,is_cylindric=true)->bool:
	return RiverSource(point.x,point.y)


func RiverSource(x,y)->bool:
	var flag=false
	var riversource = Vector2(x,y)
	var riverend:Vector2
	for p in seapoints:
		if astar.are_points_connected(x+y*world_x_size,p.x+p.y*world_x_size,false):
			flag=true
			riverend=p
			break
	if flag:
		var work = Vector3(riversource.x,riversource.y,terr.map[riversource.x][riversource.y])
		var riverpath=astar.get_point_path(int(riversource.x)+int(riversource.y)*world_x_size,int(riverend.x)+int(riverend.y)*world_x_size)#[work]
		for riv in riverpath:
			if map[int(riv.x)][int(riv.y)]!=0:
				break
			map[int(riv.x)][int(riv.y)]=1
	return flag
	

func get_potential_sources()->Array:
	var rain=par.get_node("RainfallMap")
	var pot_src=[]
	for x in range(world_x_size):
		for y in range(world_y_size):
			var gut=true
			if (rain.map[x][y]>=0.66 or terr.map[x][y]>=par.MountainThreshold*0.8):
				if gut:
					pot_src.push_back(Vector2(x,y))
	return pot_src


func gen_astar_connectivity(is_cylindrical=true):
	for x in range(world_x_size):
		for y in range(world_y_size):
			if is_cylindrical:
				if terr.map[x][y]>par.SeaLevel:
					if terr.map[(x+world_x_size+1)%world_x_size][y]<=terr.map[x][y]:
						astar.connect_points(x+world_x_size*y,((x+world_x_size+1)%world_x_size)+world_x_size*y,false)
					if terr.map[(x+world_x_size-1)%world_x_size][y]<=terr.map[x][y]:
						astar.connect_points(x+world_x_size*y,((x+world_x_size-1)%world_x_size)+world_x_size*y,false)
					if y<world_y_size-1:
						if terr.map[(x+world_x_size+1)%world_x_size][y+1]<=terr.map[x][y]:
							astar.connect_points(x+world_x_size*y,((x+world_x_size+1)%world_x_size)+world_x_size*(y+1),false)
						if terr.map[(x+world_x_size-1)%world_x_size][y+1]<=terr.map[x][y]:
							astar.connect_points(x+world_x_size*y,((x+world_x_size-1)%world_x_size)+world_x_size*(y+1),false)
						if terr.map[(x+world_x_size)%world_x_size][y+1]<=terr.map[x][y]:
							astar.connect_points(x+world_x_size*y,((x+world_x_size)%world_x_size)+world_x_size*(y+1),false)
					if y>0:
						if terr.map[(x+world_x_size+1)%world_x_size][y-1]<=terr.map[x][y]:
							astar.connect_points(x+world_x_size*y,((x+world_x_size+1)%world_x_size)+world_x_size*(y-1),false)
						if terr.map[(x+world_x_size-1)%world_x_size][y-1]<=terr.map[x][y]:
							astar.connect_points(x+world_x_size*y,((x+world_x_size-1)%world_x_size)+world_x_size*(y-1),false)
						if terr.map[(x+world_x_size)%world_x_size][y-1]<=terr.map[x][y]:
							astar.connect_points(x+world_x_size*y,((x+world_x_size)%world_x_size)+world_x_size*(y-1),false)
				else:
					if terr.map[(x+world_x_size+1)%world_x_size][y]<=par.SeaLevel:
						astar.connect_points(x+world_x_size*y,((x+world_x_size+1)%world_x_size)+world_x_size*y)
					if terr.map[(x+world_x_size-1)%world_x_size][y]<=par.SeaLevel:
						astar.connect_points(x+world_x_size*y,((x+world_x_size-1)%world_x_size)+world_x_size*y)
					if y<world_y_size-1:
						if terr.map[(x+world_x_size+1)%world_x_size][y+1]<=par.SeaLevel:
							astar.connect_points(x+world_x_size*y,((x+world_x_size+1)%world_x_size)+world_x_size*(y+1))
						if terr.map[(x+world_x_size-1)%world_x_size][y+1]<=par.SeaLevel:
							astar.connect_points(x+world_x_size*y,((x+world_x_size-1)%world_x_size)+world_x_size*(y+1))
						if terr.map[(x+world_x_size)%world_x_size][y+1]<=par.SeaLevel:
							astar.connect_points(x+world_x_size*y,((x+world_x_size)%world_x_size)+world_x_size*(y+1))
					if y>0:
						if terr.map[(x+world_x_size+1)%world_x_size][y-1]<=par.SeaLevel:
							astar.connect_points(x+world_x_size*y,((x+world_x_size+1)%world_x_size)+world_x_size*(y-1))
						if terr.map[(x+world_x_size-1)%world_x_size][y-1]<=par.SeaLevel:
							astar.connect_points(x+world_x_size*y,((x+world_x_size-1)%world_x_size)+world_x_size*(y-1))
						if terr.map[(x+world_x_size)%world_x_size][y-1]<=par.SeaLevel:
							astar.connect_points(x+world_x_size*y,((x+world_x_size)%world_x_size)+world_x_size*(y-1))
			else:
				print_debug("notyetimplemented")
	

func verify_startpoints(sp)->Array:
	var np = []
	for p in sp:
				if map[p.x][p.y]<=-1 or map[p.x][p.y]>=1:
					continue
				if map[(int(p.x)+world_x_size+1)%world_x_size][int(p.y)]<=-1 or map[(int(p.x)+world_x_size+1)%world_x_size][int(p.y)]>=1:
					continue
				if map[(int(p.x)+world_x_size-1)%world_x_size][int(p.y)]<=-1 or map[(int(p.x)+world_x_size-1)%world_x_size][int(p.y)]>=1:
					continue
				if int(p.y)<world_y_size-1:
					if map[(int(p.x)+world_x_size+1)%world_x_size][int(p.y)+1]<=-1 or map[(int(p.x)+world_x_size+1)%world_x_size][int(p.y)+1]>=1:
						continue
					if map[(int(p.x)+world_x_size-1)%world_x_size][int(p.y)+1]<=-1 or map[(int(p.x)+world_x_size-1)%world_x_size][int(p.y)+1]>=1:
						continue
					if terr.map[(int(p.x)+world_x_size)%world_x_size][int(p.y)+1]<=-1 or terr.map[(int(p.x)+world_x_size)%world_x_size][int(p.y)+1]>=1:
						continue
#				if y<world_y_size-2:
#					if map[(x+world_x_size+1)%world_x_size][y+2]!=0 or map[(x+world_x_size+2)%world_x_size][y+2]!=0:
#						continue
#					if map[(x+world_x_size-1)%world_x_size][y+2]!=0 or map[(x+world_x_size-2)%world_x_size][y+2]!=0:
#						continue
#					if terr.map[(x+world_x_size)%world_x_size][y+2]!=0:
#						continue
				if p.y>=1:
					if map[(int(p.x)+world_x_size+1)%world_x_size][int(p.y)-1]<=-1 or map[(int(p.x)+world_x_size+1)%world_x_size][int(p.y)-1]>=1:
						continue
					if map[(int(p.x)+world_x_size-1)%world_x_size][int(p.y)-1]<=-1 or map[(int(p.x)+world_x_size-1)%world_x_size][int(p.y)-1]>=1:
						continue
					if map[(int(p.x)+world_x_size)%world_x_size][int(p.y)-1]<=-1 or map[(int(p.x)+world_x_size)%world_x_size][int(p.y)-1]>=1:
						continue
#				if y>1:
#					if map[(x+world_x_size+1)%world_x_size][y-2]!=0 or map[(x+world_x_size+2)%world_x_size][y-2]:
#						continue
#					if map[(x+world_x_size-1)%world_x_size][y-2]!=0 or map[(x+world_x_size-2)%world_x_size][y-2]:
#						continue
#					if map[(x+world_x_size)%world_x_size][y-2]!=0:
#						continue
				np.push_back(p)
	return np

func get_coast_points():
	seapoints=[]
	for x in range(world_x_size):
		for y in range(world_y_size):
			var iscoast=false
			if terr.map[x][y]<=par.SeaLevel:
				if terr.map[(x+world_x_size+1)%world_x_size][y]>par.SeaLevel:
					iscoast=true
				if terr.map[(x+world_x_size-1)%world_x_size][y]>par.SeaLevel:
					iscoast=true
				if y<world_y_size-1:
					if terr.map[(x+world_x_size+1)%world_x_size][y+1]>=par.SeaLevel:
						iscoast=true
					if terr.map[(x+world_x_size-1)%world_x_size][y+1]>=par.SeaLevel:
						iscoast=true
					if terr.map[(x+world_x_size)%world_x_size][y+1]>=par.SeaLevel:
						iscoast=true
				if y>0:
					if terr.map[(x+world_x_size+1)%world_x_size][y-1]>=par.SeaLevel:
						iscoast=true
					if terr.map[(x+world_x_size-1)%world_x_size][y-1]>=par.SeaLevel:
						iscoast=true
					if terr.map[(x+world_x_size)%world_x_size][y-1]>=par.SeaLevel:
						iscoast=true
			if iscoast:
				seapoints.push_back(Vector2(x,y))


func Generate():
	map=[]
	rng.seed=layer_seed
	rng.seed=rng.randi()
	
	for x in range(world_x_size):
		map.push_back([])
		for y in range(world_y_size):
			if terr.map[x][y]>par.SeaLevel:
				map[x].push_back(int(0))
				astar.add_point(x+y*world_x_size,Vector3(x,y,terr.map[x][y]))
			else:
				map[x].push_back(int(-1))
				#seapoints.push_back(Vector2(x,y))
				astar.add_point(x+y*world_x_size,Vector3(x,y,terr.map[x][y]))
	var i=0
	
	gen_astar_connectivity()
	get_coast_points()
	
	
	var startpoints = get_potential_sources()
	verify_startpoints(startpoints)
#	startpoints.shuffle()
#	for p in startpoints:
#		map[p.x][p.y]=1
#			
#	return
	while i<par.RiverCount:
		var randiter=0#rng.randi_range(0,startpoints.size()-1)
		if(startpoints.size()==0):
			print("Can't Add more Rivers")
			break
			
		if RiverSource(startpoints[randiter].x,startpoints[randiter].y):
			i+=1
			print("New River at ",startpoints[randiter])
			#startpoints = verify_startpoints(startpoints)
			#startpoints=get_potential_sources()
			
		startpoints.remove(randiter)
