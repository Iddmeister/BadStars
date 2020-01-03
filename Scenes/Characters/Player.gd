extends KinematicBody2D

export var moveSpeed = 200

var velocity = Vector2()

func _ready():
	pass
	
func initialize(id:int):
	set_network_master(id)
	name = String(id)
	if is_network_master():
		$Camera.current = true
	pass
	
func _physics_process(delta):
	
	if Network.gameStarted:
	
		movement()
	
	pass
	
func movement():
	
	if is_network_master():
		
		var dir = Vector2()
		
		if Input.is_action_pressed("left"):
			dir.x = -1
		elif Input.is_action_pressed("right"):
			dir.x = 1
		else:
			dir.x = 0
			
		if Input.is_action_pressed("up"):
			dir.y = -1
		elif Input.is_action_pressed("down"):
			dir.y = 1
		else:
			dir.y = 0
			
		dir = dir.normalized()
		
		velocity = dir*moveSpeed
		
		velocity = move_and_slide(velocity)
		
		rpc("setPosition", global_position)
		
	pass
	
	
puppet func setPosition(pos:Vector2):
	global_position = pos
	pass
