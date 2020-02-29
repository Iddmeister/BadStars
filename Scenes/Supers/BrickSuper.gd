extends Super


export var autocharge = 50

func initialize():
	
	$Autocharge.start()
	
	pass

remotesync func super(id:int):
	
	if is_network_master():
		$Time.start()
		get_parent().invincible = true
		get_parent().frozen = true
		
	$Sprite.visible = true
	
	pass
	
remotesync func aim(dir:float):
	
	#rotation = dir
	
	pass


func _on_Time_timeout():
	get_parent().invincible = false
	get_parent().frozen = false
	rpc("off")
	pass
	
remotesync func off():
	
	$Sprite.visible = false
	
	pass


func _on_Autocharge_timeout():
	addCharge(autocharge)
	get_parent().ui.setSuperCharge(charge)
