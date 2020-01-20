extends Super

export var statMultiplier = 3
export var fireDamage = 20

var defaultSpeed:int
	
remotesync func super(id:int):
	
	if get_parent().is_network_master():
		defaultSpeed = get_parent().moveSpeed
		get_parent().moveSpeed = get_parent().moveSpeed * statMultiplier
		$Time.start()
		$Delay.start()
	$Fire.emitting = true
	
	pass
	
remotesync func aim(dir:float):
	
	#rotation = dir
	
	pass


func _on_Delay_timeout():
	
	for body in $Area.get_overlapping_bodies():
		
		if not body == get_parent():
			
			body.rpc("hit", fireDamage, get_parent().get_network_master())
		
		pass


func _on_Time_timeout():
	rpc("stopFire")
	$Delay.stop()
	get_parent().moveSpeed = defaultSpeed
	
remotesync func stopFire():
	$Fire.emitting = false
