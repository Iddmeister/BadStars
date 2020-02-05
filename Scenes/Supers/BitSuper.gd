extends Super

func _ready():
	pass
	
remotesync func super(id:int):
	
	
	if not get_parent().is_network_master():
		$Layer/Panel.visible = true
	
	if get_tree().is_network_server():
		$Time.start()
		pass
	
	
	pass
	
remotesync func hide():
	
	$Layer/Panel.visible = false
	
	pass
	


func _on_Time_timeout():
	rpc("hide")
