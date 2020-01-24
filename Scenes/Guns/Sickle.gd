extends Gun

export var speed = 130
export var damage = 50
export var returnRange = 10

var velocity = Vector2()

var returning = false

var startPos = Vector2()

var sickleDirection = 0

remotesync var sickleShot = false

func _ready():
	._ready()
	call_deferred("set_network_master", get_parent().get_network_master())

remotesync func shoot(id:int, poolIndex:int):
	
	if is_network_master():
		startPos = $Space/Sickle.global_position
		sickleDirection = global_rotation
		sickleShot = true
	
	pass
	
func _physics_process(delta):
	if is_network_master():
		if sickleShot:
			rpc_unreliable("spin")
			move(delta)
		else:
			updateToPlayer()
			
		rpc_unreliable("updatePosition", $Space/Sickle.global_position)
	
	pass
	
func updateToPlayer():
	
	$Space/Sickle.global_position = $Muzzle.global_position
	
	pass
	
func move(delta:float):
	
		
	if returning:
		
		var dir = Vector2(1, 0).rotated($Space/Sickle.get_angle_to(global_position))
		velocity = dir * speed
		$Space/Sickle.global_position += velocity*delta
		checkReturned()
		
	else:
		
		if $Space/Sickle.global_position.distance_to(startPos) >= distance:
			returning = true
		else:
			var dir = Vector2(1, 0).rotated(sickleDirection)
			velocity = dir * speed
			$Space/Sickle.global_position += velocity*delta
				
			
		
		pass
	
	pass
	
func checkReturned():
	
	if ($Space/Sickle.global_position - global_position).length() < returnRange:
		returning = false
		sickleShot = false
		canShoot = true
		ammo=1
		emit_signal("reloaded", ammo)
	
	pass
	
	
remotesync func updatePosition(pos:Vector2):
	
	$Space/Sickle.global_position = pos
	
	pass
	
remotesync func spin():
	
	$Space/Sickle/Sprite.rotation_degrees += 10
	
	pass
	
func _on_Cooldown_timeout():
	#canShoot = true
	pass


func _on_Sickle_body_entered(body):
	if not get_parent().dead:
		if is_network_master():
			if body.is_in_group("Shootable"):
				if not body.is_in_group("Ally"+String(get_parent().get_network_master())):
					
					body.rpc("hit", damage, get_parent().get_network_master())
					
					if body.is_in_group("Player") or body.is_in_group("Dummy"):
						get_tree().get_nodes_in_group("Master"+String(get_parent().get_network_master()))[0].rpc("didDamage", damage)
					
			if not body.is_in_group("Player"):
				returning = true


func _on_Gun_visibility_changed():
	if visible == false:
		$Space/Sickle.visible = false
	else:
		$Space/Sickle.visible = true
		
func _on_Reload_timeout():
	pass
