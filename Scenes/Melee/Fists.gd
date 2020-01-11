extends Melee

func _ready():
	drawAim()
	$Aim.visible = false
	$Fist.visible = false
	pass
	
remotesync func shoot(id:int, irrelevantPoolIndex:int):
	
	$Animation.play("Punch")
	
	if get_tree().is_network_server():
	
		for body in $Range.get_overlapping_bodies():
			if body.is_in_group("Shootable"):
				if not body.is_in_group("Ally"+String(id)):
					body.rpc("hit", damage, id)
					
					if body.is_in_group("Player") or body.is_in_group("Dummy"):
						get_tree().get_nodes_in_group("Ally"+String(id))[0].rpc("didDamage", damage)
