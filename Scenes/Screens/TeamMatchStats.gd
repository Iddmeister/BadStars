extends Control

func _ready():
	createPlayerStats(Network.matchStats)
	$CenterContainer/VBoxContainer/Players.get_node(Network.playerInfo.name).modulate = Color(1, 1, 0)
	
	$CenterContainer/VBoxContainer/HBoxContainer/Blue.text = String(Network.matchStats.blue)
	$CenterContainer/VBoxContainer/HBoxContainer/Red.text = String(Network.matchStats.red)
	
	pass
	
func createPlayerStats(stats:Dictionary):
	
	
	for player in stats.players.keys():
		
		var pl = Label.new()
		pl.text = String(player + "   " + "Kills: "+String(stats.players[player].kills))
		pl.name = player
		$CenterContainer/VBoxContainer/Players.add_child(pl)
		pass
		
		
	
	pass
	


func _on_Leave_pressed():
	if get_tree().is_network_server():
		Network.disconnectServer()
	else:
		Network.disconnectedFromHost()
