extends Node

signal poolCleared()

var pools = {}

var allObjects:Node2D

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	allObjects = Node2D.new()
	allObjects.name = "allObjects"
	add_child(allObjects)
	pass
	
func createPools():
	
	for player in Network.players.keys():
		
		pools[int(player)] = {}
		pools[int(player)]["bullets"] = []
		
		
		if not Globals.characterInfo[Network.players[player].character].poolSize == 0:
			var Bullet = load(Globals.characterInfo[Network.players[player].character].bulletPath)
			
			for num in range(Globals.characterInfo[Network.players[player].character].poolSize):
				
				var b = Bullet.instance()
				b.name = String(player) + String(num)
				b.id = player
				b.disable()
				pools[int(player)].bullets.append(b)
				allObjects.add_child(b)
				
				pass
				
		
		pass
	
	pass
	
func clearAllPools():
	pools = {}
	for obj in allObjects.get_children():
		obj.queue_free()
	call_deferred("emit_signal", "poolCleared")
	
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
