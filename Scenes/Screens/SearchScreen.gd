extends Control

var joinButtonScene = preload("res://Scenes/Screens/JoinButton.tscn")

func _ready():
	pass
	
func _process(delta):
	
	for game in Network.joinableGames.keys():
		if not $CenterContainer/VBoxContainer/List.has_node(game):
			var joinBut = joinButtonScene.instance()
			$CenterContainer/VBoxContainer/List.add_child(joinBut)
			joinBut.setInfo(Network.joinableGames[game])
			joinBut.name = game
		else:
			$CenterContainer/VBoxContainer/List.get_node(game).setInfo(Network.joinableGames[game])
	for game in $CenterContainer/VBoxContainer/List.get_children():
		
		if not Network.joinableGames.keys().has(game.name):
			$CenterContainer/VBoxContainer/List.remove_child(game)
		
		pass
	
	pass


func _on_Cancel_pressed():
	Network.searchPeer.close()
	Network.searchPeer = PacketPeerUDP.new()
	get_tree().change_scene("res://Scenes/Screens/MainMenu.tscn")
	get_tree().network_peer = null
	Network.joinableGames = {}
	Network.timeoutList = {}
	Network.searching = false
