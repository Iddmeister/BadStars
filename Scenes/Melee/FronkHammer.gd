extends Melee

	
remotesync func shoot(id:int, irrelevantPoolIndex:int):
	aim(false)
	$Animation.play("Slam")
	.shoot(id, irrelevantPoolIndex)
	get_parent().rpc("freeze", true)
	if get_parent().is_network_master():
		$FreezeTime.start()
	
	pass



func _on_FreezeTime_timeout():
	get_parent().rpc("freeze", false)
