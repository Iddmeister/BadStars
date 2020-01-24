extends Melee

func drawAim():
	
	$Aim.polygon = $Range/CollisionShape2D.shape.points
	
	pass
	
remotesync func shoot(id:int, irrelevantPoolIndex:int):
	$Animation.play("Slam")
	.shoot(id, irrelevantPoolIndex)
	get_parent().rpc("freeze", true)
	if get_parent().is_network_master():
		$FreezeTime.start()
	
	pass



func _on_FreezeTime_timeout():
	get_parent().rpc("freeze", false)