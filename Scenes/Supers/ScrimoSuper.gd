extends Super

var frozenBodies = []

func _ready():
	pass
	
remotesync func super(id:int):
	enableFreeze(true)
	pass
	
remotesync func aim(dir:float):
	
	#rotation = dir
	
	pass
	
func aimVisible(val:bool):
	
	pass
	
remotesync func enableFreeze(val:bool):
	
	if val:
		
		$Space/FreezeCircle.global_position = global_position
		
		$Space/FreezeCircle/Sprite.visible = true
		
		if get_tree().is_network_server():
			
			for body in $Space/FreezeCircle/Range.get_overlapping_bodies():
				
				if body.is_in_group("Freezable"):
					
					if not body == get_parent():
						
						body.rpc("freeze", true)
						frozenBodies.append(body)
						
						pass
						
			$Time.start()
			
	else:
		
		$Space/FreezeCircle/Sprite.visible = false
		
		if get_tree().is_network_server():
			
			for body in frozenBodies:
				
				body.rpc("freeze", false)
				frozenBodies.erase(body)
	
	
	pass


func _on_Time_timeout():
	rpc("enableFreeze", false)
