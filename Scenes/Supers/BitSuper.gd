extends Super

func _ready():
	$Aim.polygon = $Area2D/CollisionShape2D.shape.points
	$Aim.visible = false
	pass
	
remotesync func super(id:int):
	
	
	if not get_parent().is_network_master():
		
		for body in $Area2D.get_overlapping_bodies():
			
			if not body.is_in_group("Ally"+String(get_parent().get_network_master())):
				
				rpc_id(body.get_network_master(), "show")
				
				pass
			
			pass
			
	if get_tree().is_network_server():
		
		$Time.start()
		
		pass
	
	
	pass
	
remotesync func show():
	
	$Layer/Panel.visible = true
	print("yo")
	
	pass
	
remotesync func aim(dir:float):
	
	rotation = dir
	
	pass
	
func aimVisible(val:bool):
	
	$Aim.visible = val
	
	pass
	
remotesync func hide():
	
	$Layer/Panel.visible = false
	
	pass
	


func _on_Time_timeout():
	rpc("hide")
