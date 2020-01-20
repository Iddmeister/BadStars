extends Throwable

export var damage = 30

func _ready():
	._ready()
	$GroundSprite.visible = false
	$AirSprite.visible = false

remotesync func land():
	$AirSprite.visible = false
	$GroundSprite.visible = true
	if get_tree().is_network_server():
		$Dps.start()
		$BurnTime.start()
	pass
	
remotesync func throw(direction:float):
	.throw(direction)
	$GroundSprite.visible = false
	$AirSprite.visible = true
	
remotesync func stepAnim():
	var scaleVal
	if distanceTravelled < 0.5:
		
		scaleVal = max(0.8, distanceTravelled*5)
		
	else:
		scaleVal = max(0.2, (1-distanceTravelled)*5)
	
	$AirSprite.scale = Vector2(scaleVal, scaleVal)
	pass


func _on_BurnTime_timeout():
	$Dps.stop()
	rpc("destroy")
	$GroundSprite.visible = false


func _on_Dps_timeout():
	for body in $Area.get_overlapping_bodies():
		if body.is_in_group("Shootable"):
			if not body.is_in_group("Ally"+String(id)):
				body.rpc("hit", damage, id)
				if body.is_in_group("Player"):
					get_tree().get_nodes_in_group("Ally"+String(id))[0].rpc("didDamage", damage)
				elif body.is_in_group("Dummy"):
					get_tree().get_nodes_in_group("Ally"+String(id))[0].rpc("didDamage", damage)
