extends Control

var currentMap = "Basic"
var currentGameMode = Network.gameModes.BADROYALE
var currentMapIndex = 0

func _ready():
	$Controls/MapSelect/CurrentMap.text = currentMap
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
		currentMap = Globals.maps.keys()[currentMapIndex]
		$Controls/MapSelect/CurrentMap.text = currentMap


func _on_Right_pressed():
	if not currentMapIndex+1 > Globals.maps.keys().size()-1:
		currentMapIndex += 1
		currentMap = Globals.maps.keys()[currentMapIndex]
		$Controls/MapSelect/CurrentMap.text = currentMap
