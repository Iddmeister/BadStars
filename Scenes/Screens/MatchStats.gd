extends Control

func _ready():
	createPlayerStats(Network.matchStats)
	drawGraph(Network.matchStats.graph)
	$HBoxContainer/Players.get_node(Network.playerInfo.name).modulate = Color(1, 1, 0)
	pass
	
func createPlayerStats(stats:Dictionary):
	
	var places = stats.places
	places.invert()
	
	for num in range(places.size()):
		
		var pl = Label.new()
		pl.name = places[num]
		pl.text = String(String(num+1) +  ". " + places[num] + "   " + "Kills: "+String(stats.players[places[num]].kills))
		$HBoxContainer/Players.add_child(pl)
		pass
		
		
	
	pass
	
func drawGraph(info:Dictionary):
	
	var line = $HBoxContainer/Graph/Line
	
	line.add_point($HBoxContainer/Graph/Start.position)
	
	for point in info.points:
		
		var y = point.damage
		var x = (float(point.time-info.start)/float(info.end-info.start))*400.0
		
		line.add_point(Vector2($HBoxContainer/Graph/Start.position.x+x, $HBoxContainer/Graph/Start.position.y))
		line.add_point(Vector2($HBoxContainer/Graph/Start.position.x+x+2, $HBoxContainer/Graph/Start.position.y-y))
		line.add_point(Vector2($HBoxContainer/Graph/Start.position.x+x+4, $HBoxContainer/Graph/Start.position.y))
		pass
		
	line.add_point($HBoxContainer/Graph/End.position)
	
	pass


func _on_Leave_pressed():
	if get_tree().is_network_server():
		Network.disconnectServer()
	else:
		Network.disconnectedFromHost()
