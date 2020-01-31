extends Control

var currentMap = "Basic"
var currentMapIndex = 0

var currentGameMode = "Bad Royale"
var currentGameModeIndex = 0

var tagScene = preload("res://Scenes/UI/JoinTag.tscn")

func _ready():
	$Controls/MapSelect/CurrentMap.text = currentMap
	$Controls/GameMode/CurrentMode.text = currentGameMode
	$IP.text = "IP:  " + String(IP.get_local_addresses()[0])
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
			if currentGameMode == "Team Deathmatch":
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
