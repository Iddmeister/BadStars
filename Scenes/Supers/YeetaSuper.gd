extends Super

var bear:Minion

func initialize():
	bear = ObjectPool.pools[get_parent().get_network_master()]["minions"][0]
	pass

remotesync func super(id:int):
	
	bear.rpc("place", global_position)
	
	pass
