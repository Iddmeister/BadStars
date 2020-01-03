extends Node

var pools = {}

func _ready():
	pass
	
func createPools():
	
	for player in Network.players.keys():
		
		pools[int(player)] = {}
		pools[int(player)]["bullets"] = []
		
		var Bullet = load(Globals.characterInfo[Network.players[player].character].bulletPath)
		
		for num in range(Globals.characterInfo[Network.players[player].character].poolSize):
			
			var b = Bullet.instance()
			b.name = String(player) + String(num)
			b.disable()
			pools[int(player)].bullets.append(b)
			
			pass
		
		pass
	
	pass
	
func getAvailableObject(objects:Array) -> Node:
	
	for obj in objects:
		if not obj.enabled:
			return obj
		else:
			continue
	return null
	
	pass
	
func getAvailableObjectIndex(objects:Array) -> int:
	
	for num in range(objects.size()):
		if not objects[num].enabled:
			return num
		else:
			continue
	return -1
	
	pass
