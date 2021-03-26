extends "res://addons/MapGenTools/_WorldMetaLayer.gd"

export var rivers=[]
export var river_source_Height:float
export var river_source_Rain:float
onready var par: =get_parent()
onready var terr: = par.get_node("HeightMap")
	
var astar:AStar
var seapoints=[]

var rng=RandomNumberGenerator.new()


func hsort(a,b)->bool:
	return terr.map[a.x][a.y]<terr.map[b.x][b.y]

func RiverSource(x,y):
	var riv=[]
	var riverhead = Vector2(x,y)
	riv.push_back(riverhead)
	var depth=0
	var dirs=[]
	while map[riverhead.x][riverhead.y]>-1 && map[riverhead.x][riverhead.y]<1:
		var tmp =Vector2((int(riverhead.x)+world_x_size+1)%world_x_size,int(riverhead.y))
		if !dirs.has(tmp):
			dirs.push_front(tmp)
		if int(riverhead.y) > 0:
			tmp=Vector2(int(riverhead.x),riverhead.y-1)
			if !dirs.has(tmp):
				dirs.push_front(tmp)
		tmp=Vector2((int(riverhead.x)+world_x_size-1)%world_x_size,riverhead.y)
		if !dirs.has(tmp):
			dirs.push_front(tmp)
		if int(riverhead.y)<world_y_size-1:
			tmp=Vector2(riverhead.x,riverhead.y+1)
			if !dirs.has(tmp):
				dirs.push_front(tmp)
		dirs.sort_custom(self,"hsort")
		while riv.has(dirs[0]):
			dirs.remove(0)
			if dirs.size()<1:
				break
		if dirs.size()==0:
			depth+=1
			#riv.remove(riv.size()-1)
			riv.push_front(riverhead)
			riverhead = riv[riv.size()-1-depth]
			if depth>2:
				depth=0
				break
		elif terr.map[int(dirs[0].x)][int(dirs[0].y)]>terr.map[int(riverhead.x)][int(riverhead.y)]:
			var prev = riv[riv.size()-1]
			#if terr.map[int(dirs[0].x)][int(dirs[0].y)]>terr.map[int(prev.x)][int(prev.y)]:
			depth+=1
			if depth>5:
				break
			terr.map[int(riverhead.x)][int(riverhead.y)]=terr.map[int(dirs[0].x)][int(dirs[0].y)]
			riv.push_back(Vector2(riverhead.x,riverhead.y))
			terr.map[int(dirs[0].x)][int(dirs[0].y)]-=0.0001
			riverhead=dirs[0]
			
		else:
			riv.push_back(Vector2(riverhead.x,riverhead.y))
			riverhead=dirs[0]
			depth-=1
			clamp(depth,0,5)
	for r in riv:
		map[int(r.x)][int(r.y)]=1


func RiverSource_AStar(x,y)->bool:
	var flag=false
	var riversource = Vector2(x,y)
	var riverend:Vector2
	for p in seapoints:
		if astar.are_points_connected(x+y*world_x_size,int(p.x)+int(p.y)*world_x_size):
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
			if (rain.map[x][y]>=river_source_Rain or terr.map[x][y]>=river_source_Height):
				if gut:
					pot_src.push_back(Vector2(x,y))
	pot_src.shuffle()
	return pot_src



func verify_startpoints(sp)->Array:
	var np = []
	for p in sp:
				if map[p.x][p.y]<=-1 or map[p.x][p.y]>=1:
					continue
				if map[(int(p.x)+world_x_size+1)%world_x_size][int(p.y)]<=-1 or map[(int(p.x)+world_x_size+1)%world_x_size][int(p.y)]>=1:
					continue
				if map[(int(p.x)+world_x_size+2)%world_x_size][int(p.y)]<=-1 or map[(int(p.x)+world_x_size+2)%world_x_size][int(p.y)]>=1:
					continue
				if map[(int(p.x)+world_x_size-1)%world_x_size][int(p.y)]<=-1 or map[(int(p.x)+world_x_size-1)%world_x_size][int(p.y)]>=1:
					continue
				if map[(int(p.x)+world_x_size-2)%world_x_size][int(p.y)]<=-1 or map[(int(p.x)+world_x_size-2)%world_x_size][int(p.y)]>=1:
					continue
				if int(p.y)<world_y_size-1:
					if map[(int(p.x)+world_x_size+1)%world_x_size][int(p.y)+1]<=-1 or map[(int(p.x)+world_x_size+1)%world_x_size][int(p.y)+1]>=1:
						continue
					if map[(int(p.x)+world_x_size+2)%world_x_size][int(p.y)+1]<=-1 or map[(int(p.x)+world_x_size+2)%world_x_size][int(p.y)+1]>=1:
						continue
					if map[(int(p.x)+world_x_size-1)%world_x_size][int(p.y)+1]<=-1 or map[(int(p.x)+world_x_size-1)%world_x_size][int(p.y)+1]>=1:
						continue
					if map[(int(p.x)+world_x_size-2)%world_x_size][int(p.y)+1]<=-1 or map[(int(p.x)+world_x_size-2)%world_x_size][int(p.y)+1]>=1:
						continue
					if terr.map[(int(p.x)+world_x_size)%world_x_size][int(p.y)+1]<=-1 or terr.map[(int(p.x)+world_x_size)%world_x_size][int(p.y)+1]>=1:
						continue
				if p.y>=1:
					if map[(int(p.x)+world_x_size+1)%world_x_size][int(p.y)-1]<=-1 or map[(int(p.x)+world_x_size+1)%world_x_size][int(p.y)-1]>=1:
						continue
					if map[(int(p.x)+world_x_size+2)%world_x_size][int(p.y)-1]<=-1 or map[(int(p.x)+world_x_size+2)%world_x_size][int(p.y)-1]>=1:
						continue
					if map[(int(p.x)+world_x_size-1)%world_x_size][int(p.y)-1]<=-1 or map[(int(p.x)+world_x_size-1)%world_x_size][int(p.y)-1]>=1:
						continue
					if map[(int(p.x)+world_x_size-2)%world_x_size][int(p.y)-1]<=-1 or map[(int(p.x)+world_x_size-2)%world_x_size][int(p.y)-1]>=1:
						continue
					if map[(int(p.x)+world_x_size)%world_x_size][int(p.y)-1]<=-1 or map[(int(p.x)+world_x_size)%world_x_size][int(p.y)-1]>=1:
						continue
				if p.y>=2:
					if map[(int(p.x)+world_x_size+1)%world_x_size][int(p.y)-2]<=-1 or map[(int(p.x)+world_x_size+1)%world_x_size][int(p.y)-2]>=1:
						continue
					if map[(int(p.x)+world_x_size+2)%world_x_size][int(p.y)-2]<=-1 or map[(int(p.x)+world_x_size+2)%world_x_size][int(p.y)-2]>=1:
						continue
					if map[(int(p.x)+world_x_size-1)%world_x_size][int(p.y)-2]<=-1 or map[(int(p.x)+world_x_size-1)%world_x_size][int(p.y)-2]>=1:
						continue
					if map[(int(p.x)+world_x_size-2)%world_x_size][int(p.y)-2]<=-1 or map[(int(p.x)+world_x_size-2)%world_x_size][int(p.y)-2]>=1:
						continue
					if map[(int(p.x)+world_x_size)%world_x_size][int(p.y)-2]<=-1 or map[(int(p.x)+world_x_size)%world_x_size][int(p.y)-2]>=1:
						continue
				
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


func Generate(args):
	map=[]
	rng.seed=layer_seed
	rng.seed=rng.randi()
	
	for x in range(world_x_size):
		map.push_back([])
		for y in range(world_y_size):
			if terr.map[x][y]>par.SeaLevel:
				map[x].push_back(int(0))
#				astar.add_point(x+y*world_x_size,Vector3(x,y,terr.map[x][y]))
			else:
				map[x].push_back(int(-1))
				#seapoints.push_back(Vector2(x,y))
#				astar.add_point(x+y*world_x_size,Vector3(x,y,terr.map[x][y]))
	var i=0
	
#	gen_astar_connectivity()
	get_coast_points()
		
	var startpoints = get_potential_sources()
	startpoints = verify_startpoints(startpoints)
#	startpoints.shuffle()
#	for p in startpoints:
#		map[p.x][p.y]=1
#			
#	return
	while i<par.RiverCount:
		var randiter=rng.randi_range(0,startpoints.size()-1)
		if(startpoints.size()==0):
			print("Can't Add more Rivers")
			break
			
		#if RiverSource_AStar(int(startpoints[randiter].x),int(startpoints[randiter].y)):
		RiverSource(int(startpoints[randiter].x),int(startpoints[randiter].y))
		i+=1
		print("New River at ",startpoints[randiter])
		startpoints = verify_startpoints(startpoints)
			#startpoints=get_potential_sources()
			
