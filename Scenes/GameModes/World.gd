extends Node2D



func _ready():
	createMode(Globals.currentGameMode)
	if is_network_master():
		#Network.connect("killPlayer", self, "killPlayer")
		pass
	pass
	
func killPlayer(id:int):
	
	for player in get_tree().get_nodes_in_group("Player"):
		
		if player.name == String(id):
			
			player.rpc("die")
			
			pass
		
		pass
	
	pass
	
	
func createMode(gameMode:String):
	
	var s = load(Globals.gameModes[gameMode]).instance()
	add_child(s)
	
	pass
