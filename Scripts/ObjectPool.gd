extends Node

var Bullet = preload("res://Scenes/Bullets/Bullet.tscn")

var pools = {}

func _ready():
	pass
	
func createPools():
	
	for player in get_tree().get_nodes_in_group("Player"):
		
		pools[int(player.name)] = {}
		pools[int(player.name)]["bullets"] = []
		
		for num in range(player.poolSize):
			
			var b = Bullet.instance()
			b.disable()
			pools[int(player.name)].bullets.append(b)
			
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
