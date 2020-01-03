extends Area2D

export var speed = 500
export var distance = 1000
export var damage = 10

var startPos:Vector2

var enabled = false

var id:int

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
			rpc_unreliable("setPosition", global_position)
	
	pass
	
func enable():
	$CollisionShape2D.disabled = false
	visible = true
	enabled = true
	set_process(true)
	set_physics_process(true)
	pass
	
func disable():
	$CollisionShape2D.disabled = true
	visible = false
	enabled = false
	if is_inside_tree():
		get_parent().remove_child(self)
	set_process(false)
	set_physics_process(false)
	pass
	
	
puppet func setPosition(pos:Vector2):
	global_position = pos
	pass
	
remotesync func destroy():
	disable()
	pass


func _on_Bullet_body_entered(body):
	if get_tree().is_network_server():
		if body.is_in_group("Shootable"):
			if body.is_in_group("Enemy"):
				body.rpc("hit", damage, id)
		pass
