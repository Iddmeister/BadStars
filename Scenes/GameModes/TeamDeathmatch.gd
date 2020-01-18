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

func loadMap():
	
	var map = load(Globals.maps[Globals.currentGameMode][Network.currentMap]).instance()
	map.name = "Map"
	add_child(map)
	
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
	
func spawnPlayers():
	for player in Network.players.keys():
		var p = load(Globals.characterInfo[Network.players[player].character].playerPath).instance()
		p.name = String(player)
		p.add_to_group(Network.players[player].team)
		add_child(p)
	pass
	
func placePlayers():
	
	var spots = $Map/SpawnPoints.get_children()
	
	var blueSpots = []
	var redSpots = []
	
	for s in range(spots.size()):
		if s < 5:
			blueSpots.append(spots[s])
		else:
			redSpots.append(spots[s])
	
	for player in playerObjects.keys():
		if playerObjects[player].is_in_group("Blue"):
			var spot = rand_range(0, blueSpots.size())
			rpc("placePlayer", player, blueSpots[spot].global_position)
			blueSpots.remove(spot)
		else:
			var spot = rand_range(0, redSpots.size())
			rpc("placePlayer", player, redSpots[spot].global_position)
			redSpots.remove(spot)
		pass
	
	pass
	
remotesync func placePlayer(key:String, pos:Vector2):
	playerObjects[key].global_position = pos
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