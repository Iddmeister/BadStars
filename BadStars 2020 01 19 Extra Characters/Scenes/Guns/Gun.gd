extends Node2D

class_name Gun

signal reloaded(ammo)


export var maxAmmo = 3
export var distance = 1000
export var aimWidth = 20
onready var ammo = maxAmmo

var canShoot = true

func _ready():
	drawAim()
	$Aim.visible = false
	pass
	
remotesync func shoot(id:int, poolIndex:int):
	
	createBullet(id, poolIndex)
	
	pass
	
func createBullet(id:int, poolIndex:int, direction:float=global_rotation, pos:Vector2=$Muzzle.global_position):
	
	var b = ObjectPool.pools[id].bullets[poolIndex]
	b.global_rotation = direction
	b.global_position = pos
	b.startPos = b.global_position
	b.distance = distance
	b.enable()
	
	pass
	
func aim(do:bool):
	
	$Aim.visible = do
	
	pass
	
func drawAim():
	
	$Aim.polygon = PoolVector2Array([$Muzzle.position-Vector2(0, aimWidth/2), $Muzzle.position+Vector2(distance, 0)-Vector2(0, aimWidth/2), $Muzzle.position+Vector2(distance, 0)+Vector2(0, aimWidth/2), $Muzzle.position+Vector2(0, aimWidth/2)])
	
	pass
	

func _on_Cooldown_timeout():
	canShoot = true


func _on_Reload_timeout():
	if not ammo == maxAmmo:
		ammo += 1
		emit_signal("reloaded", ammo)
		if not ammo == maxAmmo:
			$Reload.start()
