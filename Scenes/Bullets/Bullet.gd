extends Area2D

export var speed = 500
export var distance = 1000

var startPos:Vector2

func _ready():
	startPos = global_position
	pass
	
func _physics_process(delta):
	move(delta)
	
func move(delta:float):
	
	if is_network_master():
	
		position += Vector2(1, 0).rotated(global_rotation)*speed*delta
		
		
		if (global_position - startPos).length() >= distance:
			rpc("destroy")
		else:
			rpc("setPosition", global_position)
	
	pass
	
puppet func setPosition(pos:Vector2):
	global_position = pos
	pass
	
remotesync func destroy():
	queue_free()
	pass
