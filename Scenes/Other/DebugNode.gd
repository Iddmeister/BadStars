extends Node

class_name DebugNode

var noClip = false

func _ready():
	pass
	
func _process(delta):
	
	
	if Input.is_action_just_pressed("debugDie"):
		get_parent().rpc("hit", 5000, get_parent().get_network_master())
	elif Input.is_action_just_pressed("debugHeal"):
		get_parent().health = get_parent().maxHealth
		get_parent().ui.setHealth(get_parent().health)
	elif Input.is_action_just_pressed("debugNoClip"):
		if noClip:
			get_parent().get_node("CollisionShape2D").disabled = false
			noClip = false
		else:
			get_parent().get_node("CollisionShape2D").disabled = true
			noClip = true
	
	
	pass
