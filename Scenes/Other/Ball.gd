extends RigidBody2D

export var kickNullifier:float = 0.5
export var maxSpeed:int = 1000

var puppetPos:Vector2

var startPos:Vector2

var reseting = false

func _ready():
	startPos = global_position
	pass
	
remotesync func reset():
	reseting = true
	pass
	
func _process(delta):
	if is_network_master():
		rpc("updatePos", global_position)
		if Globals.outOfBounds(global_position):
			reset()

func kick(speed:int, direction:Vector2):
	apply_central_impulse(direction*(kickNullifier*speed))
	pass
	
func _integrate_forces(state):
	
	if reseting:
		global_position = startPos
		var t = state.get_transform()
		t.origin.x = startPos.x
		t.origin.y = startPos.y
		state.set_transform(t)
		state.linear_velocity = Vector2(0, 0)
		reseting = false
		puppetPos = startPos
		rpc("updatePos", startPos)
	
	else:
		if is_network_master():
			state.linear_velocity = state.linear_velocity.clamped(maxSpeed)
		else:
			global_position = puppetPos
	
	pass
	
puppet func updatePos(pos:Vector2):
	
	puppetPos = pos
	
	pass

