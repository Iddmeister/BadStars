extends Super

export var damage = 30

remotesync func super(id:int):
	
	if get_tree().is_network_server():
	
		for player in get_tree().get_nodes_in_group("Player"):
			
			if not player.dead:
				player.rpc("hit", damage, get_parent().get_network_master())
		
			pass 
	
	pass
