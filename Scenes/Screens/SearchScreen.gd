extends Control

var joinButtonScene = preload("res://Scenes/Screens/JoinButton.tscn")

func _ready():
	pass
	
func _process(delta):
	
	for game in Network.joinableGames.keys():
		if not $CenterContainer/VBoxContainer/List.has_node(game):
			var joinBut = joinButtonScene.instance()
			$CenterContainer/VBoxContainer/List.add_child(joinBut)
			joinBut.setInfo(game, Network.joinableGames[game])
			joinBut.name = game
	
	pass


func _on_Cancel_pressed():
	Network.searchPeer.close()
	Network.searchPeer = PacketPeerUDP.new()
	get_tree().change_scene("res://Scenes/Screens/MainMenu.tscn")
	get_tree().network_peer = null
	Network.joinableGames = {}
