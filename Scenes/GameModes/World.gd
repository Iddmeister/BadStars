extends Node2D



func _ready():
	createMode(Globals.currentGameMode)
	pass
	
func createMode(gameMode:String):
	
	var s = load(Globals.gameModes[gameMode]).instance()
	add_child(s)
	
	pass
