extends Node2D

class_name Melee

signal reloaded(ammo)

export var poolSize = 100

export var maxAmmo = 3
export var distance = 1000
export var damage = 50
onready var ammo = maxAmmo

var canShoot = true

func _ready():
	pass
	
remotesync func shoot(id:int, irrelevantPoolIndex:int):
	
	if get_tree().is_network_server():
	
		for body in $Range.get_overlapping_bodies():
			if body.is_in_group("Shootable"):
				if not body.is_in_group("Ally"+String(id)):
					body.rpc("hit", damage, id)
		
		pass
	
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
