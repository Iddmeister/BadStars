extends Node2D

var effects = {}

	
func createEffects():
	
	for player in Network.players.keys():
		
		
		if Globals.characterInfo[Network.players[player].character].has("effects"):
			effects[player] = []
			for effectPath in Globals.characterInfo[Network.players[player].character]["effects"]:
				
				var effect:Effect = load(effectPath).instance()
				effects[player].append(effect)
				add_child(effect)
				effect.name = "effect"+String(player)
				effect.id = player
				effect.hide()
				
				pass
			
			pass
		
		pass
	
	pass
