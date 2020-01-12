extends Control

func _ready():
	createPlayerStats(Network.matchStats)
	pass
	
func createPlayerStats(players:Dictionary):
	
	for player in players.keys():
		
		var pl = Label.new()
		pl.text = (String(players[player].place) + ". " + player + "   " + "Kills: "+String(players[player].kills))
		$HBoxContainer/Players.add_child(pl)
		pass
		
	
	pass


func _on_Leave_pressed():
	if get_tree().is_network_server():
		Network.disconnectServer()
	else:
		Network.disconnectedFromHost()
