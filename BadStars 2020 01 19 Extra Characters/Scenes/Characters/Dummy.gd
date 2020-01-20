extends StaticBody2D

export var health = 400

func _ready():
	pass

remotesync func hit(damage, id, super:bool=false):
	
	health-=damage
	if health <= 0:
		rpc("destroy")
	
	pass
	
remotesync func destroy():
	
	visible = false
	$CollisionShape2D.set_deferred("disabled", true)
	
	pass