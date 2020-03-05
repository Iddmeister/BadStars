extends KinematicBody2D

class_name Minion

export var maxHealth = 100
onready var health = maxHealth

var enabled = false

var pOwner:int

func initialize(id:int):
	pOwner = id
	pass
	
func enable():
	$CollisionShape2D.disabled = false
	visible = true
	enabled = true
	set_process(true)
	set_physics_process(true)
	pass
	
func disable():
	visible = false
	enabled = false
	call_deferred("properDisable")
	pass
	
func properDisable():
	$CollisionShape2D.disabled = true
	set_process(false)
	set_physics_process(false)
	
remotesync func place(pos:Vector2):
	
	health = maxHealth
	global_position = pos
	enable()
	
	pass
	
	
remotesync func hit(damage:int, id:int, super:bool=false):
	
	health-=damage
	
	if health <= 0:
		rpc("destroy")
	
	pass
	
remotesync func destroy():
	
	disable()
	
	pass
