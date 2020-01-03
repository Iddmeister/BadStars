extends Node2D

export var poolSize = 100

func _ready():
	pass
	
remotesync func shoot(id:int, poolIndex:int):
	
	print(poolIndex)
	var b = ObjectPool.pools[id].bullets[poolIndex]
	b.enable()
	b.global_rotation = global_rotation
	b.global_position = $Muzzle.global_position
	get_tree().root.get_child(get_tree().root.get_child_count()-1).add_child(b)
	
	pass
