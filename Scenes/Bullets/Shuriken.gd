extends "res://Scenes/Bullets/Bullet.gd"

func _on_Bullet_body_entered(body):
	if enabled:
		if get_tree().is_network_server():
			if body.is_in_group("Shootable"):
				if not body.is_in_group("Ally"+String(id)):
					body.rpc("hit", damage, id)
					if body.is_in_group("Player"):
						get_tree().get_nodes_in_group("Ally"+String(id))[0].rpc("didDamage", damage)
						hitPlayer(body)
					elif body.is_in_group("Dummy"):
						get_tree().get_nodes_in_group("Ally"+String(id))[0].rpc("didDamage", damage)
		pass
