extends "res://Scenes/Guns/ShmellyGun.gd"

remotesync func shoot(id:int, poolIndex:int):
	
	createBullet(id, poolIndex, global_rotation-deg2rad(spread))
	createBullet(id, poolIndex+1, global_rotation-deg2rad(spread/3*2))
	createBullet(id, poolIndex+2, global_rotation-deg2rad(spread/3))
	createBullet(id, poolIndex+3, global_rotation)
	createBullet(id, poolIndex+4, global_rotation+deg2rad(spread/3))
	createBullet(id, poolIndex+5, global_rotation+deg2rad(spread/3*2))
	createBullet(id, poolIndex+6, global_rotation+deg2rad(spread))
		
	
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
