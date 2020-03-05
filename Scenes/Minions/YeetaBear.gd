extends Minion

var target:Player

export var speed = 100
export var damage = 30
export var stopDist = 30

var velocity = Vector2()
	
func findTarget():
	
	var closest:Player
	
	for player in get_tree().get_nodes_in_group("Player"):
		
		if not player.name == String(pOwner) and not player.dead:
		
			if not closest:
				closest = player
				continue
			else:
				if global_position.distance_to(player.global_position) < global_position.distance_to(closest.global_position):
					closest = player
				
	target = closest
	
	pass
	
func _physics_process(delta):
	

	if get_tree().is_network_server():
		if target and not target.dead:
			look_at(target.global_position)
			
			if global_position.distance_to(target.global_position) > stopDist:
			
				velocity = Vector2(1, 0).rotated(rotation)
				velocity = move_and_slide(velocity*speed)
		else:
			findTarget()
				
		rpc("updatePos", global_position)
		rpc("updateRot", global_rotation)
		
	
	pass
	
puppet func updatePos(pos:Vector2):
	
	global_position = pos
	
	pass
	
remotesync func updateRot(rot:float):
	
	global_rotation = rot
	
	pass
	
remotesync func place(pos:Vector2):
	.place(pos)
	
	if get_tree().is_network_server():
		$AttackSpeed.start()
		findTarget()
	
	pass
	
remotesync func destroy():
	
	.destroy()
	if get_tree().is_network_server():
		$AttackSpeed.stop()
	
	pass


func _on_AttackSpeed_timeout():
	for body in $Range.get_overlapping_bodies():
		
		if body.is_in_group("Player"):
			if not body.is_in_group("Ally"+String(pOwner)):
				body.rpc("hit", damage, pOwner)
			pass
