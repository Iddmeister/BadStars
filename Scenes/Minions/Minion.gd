extends KinematicBody2D

class_name Minion

export var maxHealth = 100
onready var health = maxHealth

var enabled = false

func initialize():
	
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
