extends Control

func _ready():
	createPlayerStats(Network.matchStats)
	$CenterContainer/Players.get_node(Network.playerInfo.name).modulate = Color(1, 1, 0)
	pass
	
func createPlayerStats(stats:Dictionary):
	
	var places = stats.places
	places.invert()
	
	for num in range(places.size()):
		
		var pl = Label.new()
		pl.name = places[num]
		pl.text = String(String(num+1) +  ". " + places[num] + "   " + "Kills: "+String(stats.players[places[num]].kills))
		$CenterContainer/Players.add_child(pl)
		pass
		
		
	
	pass


func _on_Leave_pressed():
	if get_tree().is_network_server():
		Network.disconnectServer()
	else:
		Network.disconnectedFromHost()
