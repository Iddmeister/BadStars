extends Super

export var distance = 300
export var speed:float = 1

func _ready():
	$Ray.add_exception(get_parent())
	$Ray.cast_to = Vector2(distance, 0)
	$Aim.visible = false
	$Aim.add_point(Vector2(0, 0))
	$Aim.add_point(Vector2(distance, 0))
	pass
	
	
	
func aimVisible(val:bool):
	$Aim.visible = val
	pass
	
remotesync func aim(dir:float):
	
	rotation = dir
	
	if $Ray.is_colliding():
		$Aim.set_point_position(1, Vector2(($Ray.get_collision_point()-global_position).length(), 0))
	else:
		$Aim.set_point_position(1, Vector2(distance, 0))
	
	pass
	
remotesync func super(id:int):
	
#	if get_parent().is_network_master():
#		var maxDistance:int
#		if $Ray.is_colliding():
#			maxDistance = ($Ray.get_collision_point()-global_position).length()
#		else:
#			maxDistance = distance
#		$Move.interpolate_property(get_parent(), "global_position", null, get_parent().global_position+(Vector2(maxDistance, 0).rotated(rotation)), speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT, 0)
#		$Move.start()
#		pass

	if get_parent().is_network_master():
		get_parent().rpc("knockback", Vector2(2000, 0).rotated(rotation), 0.2)
	
	pass

func playerDied():
	$Move.stop_all()
