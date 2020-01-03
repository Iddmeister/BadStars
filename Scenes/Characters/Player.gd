extends KinematicBody2D

export var moveSpeed = 200

export var poolSize = 100

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
		actions()
	
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
		
		rpc_unreliable("setPosition", global_position)
		
	pass
	
func actions():
	
	if is_network_master():
	
		$Gun.look_at(get_global_mouse_position())
		
		if Input.is_action_just_pressed("shoot"):
			$Gun.rpc("shoot", get_tree().get_network_unique_id())
			pass
	
	pass
	
	
puppet func setPosition(pos:Vector2):
	global_position = pos
	pass
