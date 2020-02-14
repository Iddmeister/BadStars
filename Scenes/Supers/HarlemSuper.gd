extends "res://Scenes/Supers/Super.gd"

export var amount = 1
export var distance = 2000
export var aimWidth = 100


func _ready():
	$Aim.visible = false
	pass

remotesync func super(id:int, direction:float=global_rotation):
	
	
	for feather in range(amount):
		var f = ObjectPool.pools[id].bullets[ObjectPool.getAvailableObjectIndex(ObjectPool.pools[get_parent().get_network_master()].bullets)]
		f.global_rotation = direction
		f.global_position = global_position
		f.startPos = global_position
		f.distance = distance
		f.enable()

remotesync func aim(dir:float):
	
	rotation = dir
	
	pass
	
func aimVisible(val:bool):
	
	if val:
		$Aim.visible = true
	else:
		$Aim.visible = false
	pass
