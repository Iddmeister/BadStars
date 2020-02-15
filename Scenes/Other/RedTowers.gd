extends StaticBody2D

export var damage = 10

var towerdmg = true

export var health = 400

remotesync func hit(damage, id, super:bool=false):
	
	health-=damage
	if health <= 0:
		rpc("destroy")
	
	pass
	
remotesync func destroy():
	
	visible = false
	$CollisionShape2D.set_deferred("disabled", true)
	
	pass
var pId = 0

var team = "Red"
func _ready():
	pass
	
	if team == "Red":
		add_to_group("Red")
		
remotesync func aim(dir:float):
	
	#rotation = dir
	
	pass
remotesync func towerdmg(val:bool):
	towerdmg = val
	if val:
		$Sprite.visible = true
		if get_tree().is_network_server():
			$HitDelay.start()
	else:
		$Sprite.visible = false
		if get_tree().is_network_server():
			$HitDelay.stop()
	
	pass

func _on_HitDelay_timeout():
	for body in $Range.get_overlapping_bodies():
		if not body.is_in_group("Ally"+String(get_parent().get_network_master())):
			body.rpc("hit", damage, pId, false)
