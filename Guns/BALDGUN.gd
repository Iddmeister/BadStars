extends Gun

export var spread:float = 108888

remotesync func shoot(id:int, poolIndex:int):
	
	createBullet(id, poolIndex, global_rotation-deg2rad(spread))
	createBullet(id, poolIndex+1, global_rotation-deg2rad(spread/2))
	createBullet(id, poolIndex+2, global_rotation)
	createBullet(id, poolIndex+3, global_rotation+deg2rad(spread/2))
	createBullet(id, poolIndex+4, global_rotation+deg2rad(spread))
		
	
	pass
	
func aim(do:bool):
	
	if do:
	
		$AimLine.clear_points()
			
		$AimLine.add_point($Muzzle.position)
		$AimLine.add_point($Muzzle.position + Vector2(distance, 0).rotated(deg2rad(-spread)))
		$AimLine.add_point($Muzzle.position + Vector2(distance, 0).rotated(deg2rad(-spread/2)))
		$AimLine.add_point($Muzzle.position + Vector2(distance, 0))
		$AimLine.add_point($Muzzle.position + Vector2(distance, 0).rotated(deg2rad(spread/2)))
		$AimLine.add_point($Muzzle.position + Vector2(distance, 0).rotated(deg2rad(spread)))
		$AimLine.add_point($Muzzle.position)
	else:
		$AimLine.clear_points()
	
	pass
