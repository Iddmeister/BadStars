extends Control

var currentMap = "Basic"
var currentMapIndex = 0

var currentGameMode = "Bad_Royale"
var currentGameModeIndex = 0

var tagScene = preload("res://Scenes/UI/JoinTag.tscn")

export var maxVoteTime = 20
var voteTime = 0

func _ready():
	$Controls/MapSelect/CurrentMap.text = currentMap
	$Controls/GameMode/CurrentMode.text = currentGameMode
	$IPStuff/IP.text = "IP:  " + Globals.localIP
	$TwitchStuff.visible = false
	pass
	
func _process(delta):
	
	for player in Network.players.keys():
		
		if not $Players.has_node(String(player)):
			
			var tag = tagScene.instance()
			tag.name = String(player)
			tag.id = player
			tag.setName(Network.players[player].name + "   -->   " + Globals.characterInfo[Network.players[player].character].name)
			tag.connect("kick", self, "kickID")
			$Players.add_child(tag)
			
		else:
			var tag = $Players.get_node(String(player))
			if currentGameMode == "Team_Deathmatch" or currentGameMode == "Bad_Ball":
				tag.setTeam(Network.players[player].team)
			else:
				tag.setTeam("None")
		
		pass
		
	for tag in $Players.get_children():
		
		if not int(tag.name) in Network.players:
			$Players.remove_child(tag)
	
	pass
	
func kickID(id:int):
	
	if not id == get_tree().get_network_unique_id():
		Network.rpc_id(id, "kick")
	else:
		Network.disconnectServer()
	
	pass


func _on_Start_pressed():
	Network.rpc("startGame", currentGameMode, currentMap)
	


func _on_Disconnect_pressed():
	Network.disconnectServer()

func _on_Left_pressed():
	if not currentMapIndex-1 < 0:
		currentMapIndex -= 1
		currentMap = Globals.maps[currentGameMode].keys()[currentMapIndex]
		$Controls/MapSelect/CurrentMap.text = currentMap


func _on_Right_pressed():
	if not currentMapIndex+1 > Globals.maps[currentGameMode].keys().size()-1:
		currentMapIndex += 1
		currentMap = Globals.maps[currentGameMode].keys()[currentMapIndex]
		$Controls/MapSelect/CurrentMap.text = currentMap


func _on_LeftM_pressed():
	if not currentGameModeIndex-1 < 0:
		currentGameModeIndex -= 1
		currentGameMode = Globals.gameModes.keys()[currentGameModeIndex]
		$Controls/GameMode/CurrentMode.text = currentGameMode
		currentMap = Globals.maps[currentGameMode].keys()[0]
		$Controls/MapSelect/CurrentMap.text = currentMap


func _on_RightM_pressed():
	if not currentGameModeIndex+1 > Globals.gameModes.keys().size()-1:
		currentGameModeIndex += 1
		currentGameMode = Globals.gameModes.keys()[currentGameModeIndex]
		$Controls/GameMode/CurrentMode.text = currentGameMode
		currentMap = Globals.maps[currentGameMode].keys()[0]
		$Controls/MapSelect/CurrentMap.text = currentMap


func _on_Team_toggled(button_pressed):
	if button_pressed:
		$Team.modulate = Color(1, 0, 0)
		Network.playerInfo.team = "Red" 
		Network.rpc("updatePlayersInfo", Network.players)
	else:
		$Team.modulate = Color(0, 0, 1)
		Network.playerInfo.team = "Blue" 
		Network.rpc("updatePlayersInfo", Network.players)


func globalHost():
	Network.upnpHost.discover(2000, 2, "InternetGatewayDevice")
	Network.upnpHost.add_port_mapping(Network.PORT)
	$IPStuff/IP.text = Network.upnpHost.query_external_address()
	
	pass
	
func disconnectGlobalHost():
	Network.upnpHost.delete_port_mapping(Network.PORT)
	$IPStuff/IP.text = Globals.localIP
	
	pass

func _on_Global_toggled(button_pressed):
	if button_pressed:
		globalHost()
	else:
		disconnectGlobalHost()


func _on_Connect_pressed():
	Twitch.setup($Twitch/Channel.text)
	yield(Twitch, "twitch_connected")
	$TwitchStuff.visible = true


func _on_VoteTime_timeout():
	voteTime-=1
	$TwitchStuff/Time.text = "Time: "+String(voteTime)
	if voteTime <= 0:
		$VoteTime.stop()
		votingFinished()
	elif voteTime == 30:
		Twitch.chat("30 Seconds Left!")
	elif voteTime == 10:
		Twitch.chat("10 Seconds Left!")
	elif voteTime == 5:
		Twitch.chat("5 Seconds Left!")
		
func votingFinished():
	
	$TwitchStuff/Map.disabled = false
	Twitch.votingFor = Twitch.NOTHING
	var winner = findWinner()
	Twitch.chat("Winner: "+ winner)
	if not winner == "":
		$TwitchStuff/Time.text = winner
	else:
		$TwitchStuff/Time.text = "No Votes"
	
	pass

func findWinner() -> String:
	
	var winner:String
	
	for map in Twitch.votes.keys():
		
		if winner == "":
			winner = map
			continue
			
		else:
			if Twitch.votes[map] > Twitch.votes[winner]:
				winner = map
				
	return winner
		
	
	pass

func _on_Map_pressed():
	$TwitchStuff/Map.disabled = true
	voteTime = maxVoteTime
	Twitch.resetVotes()
	Twitch.votingFor = Twitch.MAP
	$VoteTime.start()
	Twitch.chat("Map Voting Started!")
