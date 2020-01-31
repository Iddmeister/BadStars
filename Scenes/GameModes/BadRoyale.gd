extends Node2D


var playerObjects = {}

var gameWon = false


func _ready():
	set_process(false)
	set_network_master(1)
	loadMap()
	spawnPlayers()
	ObjectPool.createPools()
	Effects.createEffects()
	setReady()
	pass
	
func _process(delta):
	
	if get_tree().is_network_server():
		if Network.gameStarted:
			if not gameWon:
				var notDead = 0
				var winner:Node2D
				for player in get_tree().get_nodes_in_group("Player"):
					if not player.dead:
						notDead += 1
						winner = player
						
				if notDead == 1:
					gameWon = true
					Network.matchStats.places.append(Network.players[int(winner.name)].name)
					Network.rpc("event", Globals.events.MESSAGE, {"message":Network.players[int(winner.name)].name + " Wins!"}, true)
					if not get_tree().get_nodes_in_group("Player").size() == 1:
						$Delay.start()
					pass
	
	pass
	
func loadMap():
	
	var map = load(Globals.maps[Globals.currentGameMode][Network.currentMap]).instance()
	map.name = "Map"
	add_child(map)
	
	pass

func spawnPlayers():
	for player in Network.players.keys():
		var p = load(Globals.characterInfo[Network.players[player].character].playerPath).instance()
		p.name = String(player)
		add_child(p)
	pass
	
func placePlayers():
	
	var spots = $Map/SpawnPoints.get_children()
	
	for player in playerObjects.keys():
		var spot = rand_range(0, spots.size())
		rpc("placePlayer", player, spots[spot].global_position)
		spots.remove(spot)
		pass
	
	pass
	
remotesync func placePlayer(key:String, pos:Vector2):
	playerObjects[key].global_position = pos
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
	set_process(true)
	get_tree().paused = false
	
	for player in get_tree().get_nodes_in_group("Player"):
		if player.has_method("initialize"):
			player.initialize(int(player.name))
			playerObjects[player.name] = player
		
	if get_tree().is_network_server():
		placePlayers()
		
	Network.gameStarted = true
	Network.starting = false
	
	pass

func _on_Delay_timeout():
	Network.rpc("endGame", Network.matchStats)
