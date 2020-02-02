extends Node2D

var playerObjects = {}

var gameWon = false

var scores = {"blue":0, "red":0}


func _ready():
	set_process(false)
	set_network_master(1)
	loadMap()
	spawnPlayers()
	ObjectPool.createPools()
	Effects.createEffects()
	setReady()
	if is_network_master():
		for goal in get_tree().get_nodes_in_group("Goal"):
			goal.connect("goalScored", self, "goalScored")
			pass
	pass
	
	
func _process(delta):
	
	if get_tree().is_network_server():
		
		if Network.gameStarted:
			
			rpc("setTime", int($Time.time_left))
			rpc("updateGoals", scores.blue, scores.red)
		
		pass
	
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
		p.setTeam(Network.players[player].team)
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
	playerObjects[key].respawnPoint = pos
	pass
	
	
remotesync func teamPlayers():
	
	for player in get_tree().get_nodes_in_group("Blue"):
		
		for player2 in get_tree().get_nodes_in_group("Blue"):
			
			player.add_to_group("Ally"+String(player2.get_network_master()))
			
			pass
		
		pass
		
	for player in get_tree().get_nodes_in_group("Red"):
		
		for player2 in get_tree().get_nodes_in_group("Red"):
			
			player.add_to_group("Ally"+String(player2.get_network_master()))
			
			pass
		
		pass
	
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
		
	teamPlayers()
	
	for player in get_tree().get_nodes_in_group("Player"):
		player.canRespawn = true
		
	Network.gameStarted = true
	Network.starting = false
	if get_tree().is_network_server():
		$Time.start()
	
	pass
	
remotesync func setTime(time:int):
	$UI/Control/Info/Time.text = String(time)
	if time <= 15:
		$UI/Control/Info/Time.modulate = Color(1, 0, 0)
	pass
	
remotesync func updateGoals(blueGoals:int, redGoals:int):
	$UI/Control/Info/Scores/Blue.text = String(blueGoals)
	$UI/Control/Info/Scores/Red.text = String(redGoals)
	pass
	
	
func goalScored(team:int):
	
	if team == 0:
		scores.red += 1
		Network.rpc("event", Globals.events.MESSAGE, {"message":"Red Scored!"}, false)
	else:
		scores.blue += 1
		Network.rpc("event", Globals.events.MESSAGE, {"message":"Blue Scored!"}, false)
		
	
	rpc("updateGoals", scores.blue, scores.red)
	rpc("resetGame")
	
	pass
	
remotesync func resetGame():
	
	get_tree().get_nodes_in_group("Ball")[0].reset()
	
	if is_network_master():
		for player in get_tree().get_nodes_in_group("Player"):
			player.rpc("respawn")
			pass
		pass
	
	pass

func _on_Time_timeout():
	var text:String
	
	Network.matchStats.blue = scores.blue
	Network.matchStats.red = scores.red
	
	if scores.blue > scores.red:
		text = "Blue Wins!"
	elif scores.red > scores.blue:
		text = "Red Wins!"
	else:
		text = "Draw!"
	Network.rpc("event", Globals.events.MESSAGE, {"message":text}, true)
	if Network.players.size() > 1:
		$Delay.start()



func _on_Delay_timeout():
	Network.rpc("endGame", Network.matchStats)
