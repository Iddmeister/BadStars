extends Control

func _ready():
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
	Network.rpc("startGame")
	


func _on_Disconnect_pressed():
	Network.disconnectServer()
	get_tree().change_scene("res://Scenes/Screens/MainMenu.tscn")