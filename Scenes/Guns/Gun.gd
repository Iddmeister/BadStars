extends Node2D

class_name Gun

signal reloaded(ammo)


export var poolSize = 100

export var maxAmmo = 3
export var distance = 1000
onready var ammo = maxAmmo

var canShoot = true

func _ready():
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
	
	if do:
	
		$AimLine.clear_points()
			
		$AimLine.add_point($Muzzle.position)
		$AimLine.add_point($Muzzle.position + Vector2(distance, 0))
	else:
		$AimLine.clear_points()
	
	pass
	

func _on_Cooldown_timeout():
	canShoot = true


func _on_Reload_timeout():
	if not ammo == maxAmmo:
		ammo += 1
		emit_signal("reloaded", ammo)
		if not ammo == maxAmmo:
			$Reload.start()
