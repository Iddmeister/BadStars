extends Gun

export var spread = 30

	
remotesync func shoot(id:int, poolIndex:int):
	
	createBullet(id, poolIndex, global_rotation-deg2rad(spread))
	createBullet(id, poolIndex+1, global_rotation)
	createBullet(id, poolIndex+2, global_rotation+deg2rad(spread))
	
		
	
	pass
	
func drawAim():
	
	$Aim.polygon = PoolVector2Array([
	$Muzzle.position,
	$Muzzle.position + Vector2(distance, 0).rotated(deg2rad(-spread)),
	$Muzzle.position + Vector2(distance, 0).rotated(deg2rad(-spread/2)),
	$Muzzle.position + Vector2(distance, 0),
	$Muzzle.position + Vector2(distance, 0).rotated(deg2rad(spread/2)),
	$Muzzle.position + Vector2(distance, 0).rotated(deg2rad(spread)),
	$Muzzle.position
	
	])
	
	pass
