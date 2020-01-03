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
