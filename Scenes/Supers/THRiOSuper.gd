extends Super

remotesync func super(id:int):
	
	setInvisible(true)
	if get_parent().is_network_master():
		$Time.start()
	
	pass
	
remotesync func setInvisible(val:bool):
	
	if val:
		get_parent().remove_from_group("Autoaim")
		if get_parent().is_network_master():
			
			get_parent().modulate = Color(1, 1, 1, 0.5)
			
		else:
			get_parent().visible = false
			
	else:
		get_parent().add_to_group("Autoaim")
		if get_parent().is_network_master():
			
			get_parent().modulate = Color(1, 1, 1, 1)
			
		else:
			get_parent().visible = true
	
	pass
	
remotesync func aim(dir:float):
	
	#rotation = dir
	
	pass


func _on_Time_timeout():
	rpc("setInvisible", false)
