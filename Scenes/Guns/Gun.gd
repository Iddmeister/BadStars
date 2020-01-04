extends Node2D

signal reloaded(ammo)

class_name Gun

export var poolSize = 100

export var maxAmmo = 3
onready var ammo = maxAmmo

var canShoot = true

func _ready():
	$Reload.start()
	pass
	
remotesync func shoot(id:int, poolIndex:int):
	
	var b = ObjectPool.pools[id].bullets[poolIndex]
	b.global_rotation = global_rotation
	b.global_position = $Muzzle.global_position
	b.startPos = b.global_position
	b.enable()
	
	
	pass
	

func _on_Cooldown_timeout():
	canShoot = true


func _on_Reload_timeout():
	if not ammo == maxAmmo:
		ammo += 1
		emit_signal("reloaded", ammo)
		if not ammo == maxAmmo:
			$Reload.start()
