extends Super

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

