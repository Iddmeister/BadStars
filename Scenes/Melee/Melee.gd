extends Node2D

class_name Melee

signal reloaded(ammo)

export var maxAmmo = 3
export var distance = 1000
export var damage = 50
export var aimWidth = 20
onready var ammo = maxAmmo

var canShoot = true

func _ready():
	drawAim()
	$Aim.visible = false
	$Ray.add_exception(get_parent())
	pass
	
remotesync func shoot(id:int, irrelevantPoolIndex:int):
	
	if get_tree().is_network_server():
	
		for body in $Range.get_overlapping_bodies():
			if body.is_in_group("Shootable"):
				if not body.is_in_group("Ally"+String(id)):
					
					var colliding = false
					
					$Ray.global_rotation = (body.global_position-global_position).angle()
					
					if $Ray.is_colliding():
						
						if not $Ray.get_collider() == body:
							colliding = true
						
					if not colliding:
					
						body.rpc("hit", damage, id)
						if body.is_in_group("Player"):
							hitPlayer(body)
						if body.is_in_group("Player") or body.is_in_group("Dummy"):
							get_tree().get_nodes_in_group("Master"+String(id))[0].rpc("didDamage", damage)
		
		pass
	
	pass
	
func hitPlayer(p:Player):
	pass
	
func aim(do:bool):
	
	$Aim.visible = do
	
	pass

func drawAim():
	
	$Aim.polygon = $Range/CollisionPolygon2D.polygon
	$Aim.global_position = $Range/CollisionPolygon2D.global_position
	
	pass

func _on_Cooldown_timeout():
	canShoot = true


func _on_Reload_timeout():
	if not ammo == maxAmmo:
		ammo += 1
		emit_signal("reloaded", ammo)
		if not ammo == maxAmmo:
			$Reload.start()
