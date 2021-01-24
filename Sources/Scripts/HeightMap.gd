extends "res://addons/MapGenTools/_WorldMetaLayer.gd"


func fault_row_calc(args:Array):
	var t_id=args[0]
	var div=args[1]
	var mod=args[2]
	var sr= args[3]
	var x=0
	while x < world_x_size:
		if x%mod==t_id:
			for y in world_y_size:
				if div.cross(Vector2(x-sr.x,y-sr.y))>=0:
					map[x][y]+= 1.1 
				else:
					map[x][y]-= 1.1
		x+=1

func GenerateHeightMap_plasma(depth:int=7,displace:float=110.0,roughness:float=1.0):
	world_x_size=int(pow(2,depth))+1
	world_y_size=world_x_size
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	map=[]
	for i in range(world_x_size):
		map.append([])
		for _j in range(world_y_size):
			map[i].append(0.0)
	var stepsize=int(pow(2,depth))
	while stepsize>1:
		for x in range(0,world_x_size,stepsize):
			if x+stepsize<world_x_size:
				for y in range(0,world_y_size,stepsize):
					if y+stepsize<world_y_size:
						map[(x+x+stepsize)/2][(y+y+stepsize)/2]=rng.randf_range(-displace,displace)+(map[x][y]+map[x][y+stepsize]+map[stepsize+x][stepsize+y]+map[stepsize+x][y])/4.0
		for x in range(0,world_x_size,stepsize):
			if x+stepsize<world_x_size:
				for y in range(0,world_y_size,stepsize):
					if y+stepsize<world_y_size:
						var srod_x=(x+x+stepsize)/2
						var srod_y=(y+y+stepsize)/2
						var far_x=x+stepsize
						var far_y=y+stepsize
						var before_x= x-stepsize/2
						var before_y= y-stepsize/2
						var after_x=far_x+stepsize/2
						var after_y= far_y+stepsize/2
						
						if x==0:
							map[x][srod_y]=(map[srod_x][srod_y]+map[x][y]+map[x][far_y])/3+rng.randf_range(-displace,displace)
						else:
							map[x][srod_y]=(map[srod_x][srod_y]+map[x][y]+map[x][far_y]+map[before_x][srod_y])/4+rng.randf_range(-displace,displace)
						
						if y==0:
							map[srod_x][y]=(map[srod_x][srod_y]+map[x][y]+map[far_x][y])/3+rng.randf_range(-displace,displace)
						else:
							map[srod_x][y]=(map[srod_x][srod_y]+map[x][y]+map[far_x][y]+map[srod_x][before_y])/4+rng.randf_range(-displace,displace)
						
						if far_x==world_x_size-1:
							map[far_x][srod_y]=(map[srod_x][srod_y]+map[far_x][y]+map[far_x][far_y])/3+rng.randf_range(-displace,displace)
						else:
							map[far_x][srod_y]=(map[srod_x][srod_y]+map[far_x][y]+map[far_x][far_y]+map[after_x][srod_y])/4+rng.randf_range(-displace,displace)
						
						if far_y==world_y_size-1:
							map[srod_x][far_y]=(map[srod_x][srod_y]+map[x][far_y]+map[far_x][far_y])/3+rng.randf_range(-displace,displace)
						else:
							map[srod_x][far_y]=(map[srod_x][srod_y]+map[x][far_y]+map[far_x][far_y]+map[srod_x][after_y])/4+rng.randf_range(-displace,displace)
		stepsize/=2
		displace*=pow(2,-roughness)
	pass

func GenerateCylindricHeightMap_plasma(depth:int=7,displace:float=110.0,roughness:float=1.0):
	world_x_size=int(pow(2,depth))+1
	world_y_size=world_x_size
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	map=[]
	for i in range(world_x_size):
		map.append([])
		for _j in range(world_y_size):
			map[i].append(0.0)
	var stepsize=int(pow(2,depth))
	while stepsize>1:
		for x in range(0,world_x_size,stepsize):
				for y in range(0,world_y_size,stepsize):
					if y+stepsize<world_y_size:
						map[((x+x+stepsize)/2)%world_x_size][(y+y+stepsize)/2]=rng.randf_range(-displace,displace)+(map[x%world_x_size][y]+map[x%world_x_size][y+stepsize]+map[(stepsize+x)%world_x_size][stepsize+y]+map[(stepsize+x)%world_x_size][y])/4.0
		for x in range(0,world_x_size,stepsize):
				for y in range(0,world_y_size,stepsize):
					if y+stepsize<world_y_size:
						var srod_x=(x+x+stepsize)/2
						var srod_y=(y+y+stepsize)/2
						var far_x=x+stepsize
						var far_y=y+stepsize
						var before_x= x-stepsize/2
						var before_y= y-stepsize/2
						var after_x=far_x+stepsize/2
						var after_y= far_y+stepsize/2
						
						map[x%world_x_size][srod_y]=(map[srod_x%world_x_size][srod_y]+map[x%world_x_size][y]+map[x%world_x_size][far_y]+map[(world_x_size+before_x)%world_x_size][srod_y])/4+rng.randf_range(-displace,displace)
						
						if y==0:
							map[srod_x%world_x_size][y]=(map[srod_x%world_x_size][srod_y]+map[x%world_x_size][y]+map[far_x%world_x_size][y])/3#+rng.randf_range(-displace,displace)
						else:
							map[srod_x%world_x_size][y]=(map[srod_x%world_x_size][srod_y]+map[x%world_x_size][y]+map[far_x%world_x_size][y]+map[srod_x%world_x_size][before_y])/4#+rng.randf_range(-displace,displace)
						
						map[far_x%world_x_size][srod_y]=(map[srod_x%world_x_size][srod_y]+map[far_x%world_x_size][y]+map[far_x%world_x_size][far_y]+map[after_x%world_x_size][srod_y])/4#+rng.randf_range(-displace,displace)
						
						if far_y==world_y_size-1:
							map[srod_x%world_x_size][far_y]=(map[srod_x%world_x_size][srod_y]+map[x%world_x_size][far_y]+map[far_x%world_x_size][far_y])/3#+rng.randf_range(-displace,displace)
						else:
							map[srod_x%world_x_size][far_y]=(map[srod_x%world_x_size][srod_y]+map[x%world_x_size][far_y]+map[far_x%world_x_size][far_y]+map[srod_x%world_x_size][after_y])/4#+rng.randf_range(-displace,displace)
		stepsize/=2
		displace*=pow(2,-roughness)
	pass


func GenerateHeightMap_fault(x_size:int=100,y_size:int=100,repeats:int=500):
	world_x_size=x_size
	world_y_size=y_size
	print("1",OS.get_time())
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	map=[]
	for i in range(world_x_size):
		map.append([])
		for _j in range(world_y_size):
			map[i].append(0.0)
	print("2",OS.get_time())
	for _k in range(repeats):
		var thrs=[]
		var randx1=rng.randi_range(0,world_x_size)
		var randx2=rng.randi_range(0,world_x_size)
		var randy1=rng.randi_range(0,world_y_size)
		var randy2=rng.randi_range(0,world_y_size)
		#print("1(",randx1,",",randy1,")"," (",randx2,",",randy2,")")
		var div = Vector2((randx2-randx1),(randy2-randy1))
		if randy1 == randy2 and randx1==randx2:
				pass
		else:
			var maxthrs = 16
			for i in range(maxthrs):
					thrs.append(Thread.new())
					thrs[i].start(self,"fault_row_calc",[i,div,maxthrs,Vector2(randx1,randy1)])
			for i in thrs:
				i.wait_to_finish()
		

func GenerateHeightMap_OpenSimplex(x_size:int=800,y_size:int=600, offset:Vector2=Vector2(0,0), difference=1, lacun:float=2.0,persist:float=0.5,period:float=64.0,octaves=3):
	map=[]
	var osn = OpenSimplexNoise.new()
	osn.seed=layer_seed
	osn.lacunarity=lacun
	osn.period=period
	osn.persistence=persist
	osn.octaves=octaves
	world_x_size=x_size
	world_y_size=y_size
	for x in range(x_size):
		map.append([])
		for y in range(y_size):
			map[x].append(osn.get_noise_2d(x+offset.x,y+offset.y)*difference)
			


func Erode(cutoff:float,iterations:int=1,strength:float=0.01):
	var rng=RandomNumberGenerator.new()
	rng.set_seed(layer_seed)
	for _i in range(iterations):
		#var drx=rng.randi_range(0,world_x_size-1)
		#var dry=rng.randi_range(0,world_y_size-1)
		for drx in range(world_x_size):
			for dry in range(world_y_size):
				var drop = Vector3(drx,dry,0)
				while map[drop.x][drop.y]>0.0:
					if map[drop.x][drop.y]>=cutoff:
						map[drop.x][drop.y]-=strength
					elif map[drop.x][drop.y]<cutoff*0.5:
						map[drop.x][drop.y]-=strength*0.5
					else:
						map[drop.x][drop.y]+=strength*0.2
					drop.z=map[drop.x][drop.y]
					var newdrop = drop
					if newdrop.y > 0.0:
						if map[(world_x_size+int(drop.x-1))%world_x_size][(int(drop.y-1))%world_y_size]<=newdrop.z:
							newdrop=Vector3((world_x_size+int(drop.x-1))%world_x_size,(int(drop.y-1))%world_y_size,newdrop.z)
						if  map[(world_x_size+int(drop.x))%world_x_size][(int(drop.y-1))%world_y_size]<=newdrop.z:
							newdrop=Vector3((world_x_size+int(drop.x))%world_x_size,(int(drop.y-1))%world_y_size,newdrop.z)
						if  map[(world_x_size+int(drop.x+1))%world_x_size][(int(drop.y-1))%world_y_size]<=newdrop.z:
							newdrop=Vector3((world_x_size+int(drop.x+1))%world_x_size,(int(drop.y-1))%world_y_size,newdrop.z)
					if map[(world_x_size+int(drop.x+1))%world_x_size][(int(drop.y))%world_y_size]<=newdrop.z:
						newdrop=Vector3((world_x_size+int(drop.x+1))%world_x_size,(int(drop.y))%world_y_size,newdrop.z)
					if newdrop.y<world_y_size-1:
						if map[(world_x_size+int(drop.x+1))%world_x_size][(int(drop.y+1))%world_y_size]<=newdrop.z:
							newdrop=Vector3((world_x_size+int(drop.x+1))%world_x_size,(int(drop.y+1))%world_y_size,newdrop.z)
						if map[(world_x_size+int(drop.x))%world_x_size][(int(drop.y+1))%world_y_size]<=newdrop.z:
							newdrop=Vector3((world_x_size+int(drop.x))%world_x_size,(int(drop.y+1))%world_y_size,newdrop.z)
						if map[(world_x_size+int(drop.x-1))%world_x_size][(int(drop.y+1))%world_y_size]<=newdrop.z:
							newdrop=Vector3((world_x_size+int(drop.x-1))%world_x_size,(int(drop.y+1))%world_y_size,newdrop.z)
					if map[(int(drop.x-1))%world_x_size][(int(drop.y))%world_y_size]<=newdrop.z:
						newdrop=Vector3((world_x_size+int(drop.x-1))%world_x_size,(int(drop.y))%world_y_size,newdrop.z)
					if newdrop == drop:
						break


func GenerateCylindricHeightMap_OpenSimplex(y_size:int=450, offset:Vector3=Vector3(0,0,0), lacun:float=2.0,persist:float=0.5,period:float=64.0,octaves:int=4):
	map=[]
	
	var osn = OpenSimplexNoise.new()
	osn.set_seed(layer_seed)
	osn.lacunarity = lacun
	osn.period = period
	osn.persistence = persist
	osn.octaves = octaves
	
	world_y_size = y_size
	world_x_size = int(1.75*y_size)
	get_parent().world_x_size = world_x_size
	get_parent().world_y_size = world_y_size
	
	var radius = float(world_x_size)/(2.0*PI)
	
	for x in range(world_x_size):
		map.append([])
		var deg = float(float(x)/float(world_x_size))*2*PI
		
		for y in range(world_y_size):

			map[x].append(osn.get_noise_3d(cos(deg)*radius+offset.x,sin(deg)*radius+offset.y,y+offset.z)/0.8)
