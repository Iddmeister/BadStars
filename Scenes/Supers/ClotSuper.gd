extends Super

export var damage = 100

func _ready():
	pass
	
func aimVisible(val:bool):
	
	if val:
		$AimLine.clear_points()
		$AimLine.add_point(Vector2(0, 0))
		$AimLine.add_point(Vector2($Laser/CollisionShape2D.shape.extents.x*2, 0))
	else:
		$AimLine.clear_points()
	
	pass
	
remotesync func super(id:int):
	$Space/LaserLine.clear_points()
	$Space/LaserLine.add_point(global_position)
	$Space/LaserLine.add_point(global_position+Vector2($Laser/CollisionShape2D.shape.extents.x*2, 0).rotated(rotation))
	$Time.start()
	if get_tree().is_network_server():
		
		for body in $Laser.get_overlapping_bodies():
			
			if not body.is_in_group("Ally"+String(get_parent().get_network_master())):
				body.rpc("hit", damage, id, true)
			
			pass
		
		
		pass
	pass


func _on_Time_timeout():
	$Space/LaserLine.clear_points()
