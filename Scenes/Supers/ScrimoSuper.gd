extends Super

var frozenBodies = []

var dropped = false

func _ready():
	pass
	
func _physics_process(delta):
	if not dropped:
		$Space/FreezeCircle.global_position = global_position
	
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
		
		dropped = true
		
		if get_tree().is_network_server():
			$Space/FreezeCircle/Range.update()
			for body in $Space/FreezeCircle/Range.get_overlapping_bodies():
				if body.is_in_group("Freezable"):
			
					if not body.is_in_group("Ally"+String(get_parent().get_network_master())):
					
						body.rpc("freeze", true)
						frozenBodies.append(body)
				
				pass
			$Time.start()
			
	else:
		
		$Space/FreezeCircle/Sprite.visible = false
		dropped = false
		
		if get_tree().is_network_server():
			
			for body in frozenBodies:
				
				body.rpc("freeze", false)
				frozenBodies.erase(body)
	
	
	pass
	


func _on_Time_timeout():
	rpc("enableFreeze", false)

