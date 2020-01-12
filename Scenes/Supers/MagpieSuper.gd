extends Super

export var amount = 10
export var distance = 400
	
	
remotesync func super(id:int):
	
	
	for feather in range(amount):
		var f = ObjectPool.pools[id].bullets[ObjectPool.getAvailableObjectIndex(ObjectPool.pools[get_parent().get_network_master()].bullets)]
		f.global_rotation = deg2rad(((float(feather)/amount)*360))
		f.global_position = global_position
		f.startPos = global_position
		f.distance = distance
		f.enable()
	
	pass
	
remotesync func aim(dir:float):
	
	#rotation = dir
	
	pass
