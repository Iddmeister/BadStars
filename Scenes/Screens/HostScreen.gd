extends Control

var currentMap = "Basic"
var currentMapIndex = 0

var currentGameMode = "Bad Royale"
var currentGameModeIndex = 0


func _ready():
	$Controls/MapSelect/CurrentMap.text = currentMap
	$Controls/GameMode/CurrentMode.text = currentGameMode
	pass
	
func _process(delta):
	
	for player in Network.players.keys():
		
		if not $Players.has_node(Network.players[player].name):
			
			var label = Label.new()
			$Players.add_child(label)
			if not player == 1:
				label.text = Network.players[player].name + " : " + get_tree().network_peer.get_peer_address(player)
			else:
				label.text = Network.players[player].name + " : " + IP.get_local_addresses()[1]
			label.name = Network.players[player].name
			label.align = Label.ALIGN_CENTER
		
		pass
	
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
