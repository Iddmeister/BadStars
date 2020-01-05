extends Node2D


var playerScene = preload("res://Scenes/Characters/Clot.tscn")


func _ready():
	spawnPlayers()
	ObjectPool.createPools()
	setReady()
	pass

func spawnPlayers():
	for player in Network.players.keys():
		var p = playerScene.instance()
		p.name = String(player)
		add_child(p)
	pass
	
func setReady():
	if not get_tree().is_network_server():
		Network.rpc_id(1, "readyPlayer", get_tree().get_network_unique_id())
	else:
		Network.readyPlayer(1)
	if get_tree().is_network_server():
		
		yield(Network, "allPlayersReady")
		
		rpc("startGame")
		
	pass
	
remotesync func startGame():
	get_tree().paused = false
	
	for player in get_tree().get_nodes_in_group("Player"):
		player.initialize(int(player.name))
		
	Network.gameStarted = true
	Network.starting = false
	
	pass