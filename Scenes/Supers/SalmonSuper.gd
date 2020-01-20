extends Super

var enabled = false

func _ready():
	pass
	
func _process(delta):
	
	if enabled:
	
		for area in $Shield.get_overlapping_areas():
			
			if area.is_in_group("Bullet"):
				
				if not area.id == get_parent().get_network_master():
					
					area.rpc("destroy")
					get_tree().get_nodes_in_group("Ally"+String(area.id))[0].rpc("hit", area.damage, get_parent().get_network_master())
					
					pass
			
			pass
	
	pass
	
remotesync func aim(dir:float):
	
	#rotation = dir
	
	pass
	
remotesync func super(id:int):
	
	$Time.start()
	
	$ShieldSprite.visible = true
	$Card.visible = true
	if get_tree().is_network_server():
		enabled = true
	
	pass
	
remotesync func disable():
	
	$ShieldSprite.visible = false
	$Card.visible = false
	if get_tree().is_network_server():
		enabled = false
	
	pass
	


func _on_Time_timeout():
	rpc("disable")
