extends Super

var enabled = false

func initialize():
	
	get_parent().connect("playerHit", self, "reverse")
	
	pass
	
func reverse(damage:int, id:int):
	
	if enabled:
	
		rpc("damagePlayer", damage, id)
	
	pass
	
remotesync func damagePlayer(damage:int, id:int):
	
	if get_tree().is_network_server():
		
		get_tree().get_nodes_in_group("Master"+String(id))[0].rpc("hit", damage, get_parent().get_network_master())
	
	pass
	
remotesync func aim(dir:float):
	
	#rotation = dir
	
	pass
	
remotesync func super(id:int):
	
	$ShieldSprite.visible = true
	$Card.visible = true
	
	if get_parent().is_network_master():
		$Time.start()
		get_parent().invincible = true
		enabled = true
	
	pass
	
remotesync func disable():
	
	$ShieldSprite.visible = false
	$Card.visible = false
	if get_parent().is_network_master():
		get_parent().invincible = false
		enabled = false
	
	pass
	


func _on_Time_timeout():
	rpc("disable")
