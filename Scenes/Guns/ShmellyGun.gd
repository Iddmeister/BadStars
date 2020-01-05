extends Gun

export var spread:float = 15

remotesync func shoot(id:int, poolIndex:int):
	
	createBullet(id, poolIndex, global_rotation-deg2rad(spread))
	createBullet(id, poolIndex+1, global_rotation-deg2rad(spread/2))
	createBullet(id, poolIndex+2, global_rotation)
	createBullet(id, poolIndex+3, global_rotation+deg2rad(spread/2))
	createBullet(id, poolIndex+4, global_rotation+deg2rad(spread))
		
	
	pass
