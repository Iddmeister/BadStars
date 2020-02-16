extends "res://Scenes/Supers/ShmellySuper.gd"


remotesync func enablePoison(val:bool):
	poisoning = val
	if val:
		$Animation.play("Plane")
		$Sprite.visible = true
		if get_tree().is_network_server():
			$HitDelay.start()
	else:
		$Sprite.visible = false
		if get_tree().is_network_server():
			$HitDelay.stop()

func _on_Time_timeout():
	rpc("enablePoison", false)
	get_parent().rpc("hit", 1000, get_parent().get_network_master())

	
