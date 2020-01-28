extends RigidBody2D

export var kickNullifier:float = 0.5
export var maxSpeed:int = 1000

func _ready():
	pass

func kick(speed:int, direction:Vector2):
	apply_central_impulse(direction*(kickNullifier*speed))
	pass
	
func _integrate_forces(state):
	
	state.linear_velocity = state.linear_velocity.clamped(maxSpeed)
	
	pass
