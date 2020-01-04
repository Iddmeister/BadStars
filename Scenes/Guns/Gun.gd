extends Node2D

export var poolSize = 100

func _ready():
	pass
	
remotesync func shoot(id:int, poolIndex:int):
	
	var b = ObjectPool.pools[id].bullets[poolIndex]
	b.global_rotation = global_rotation
	b.global_position = $Muzzle.global_position
	b.startPos = b.global_position
	b.enable()
	
	pass
