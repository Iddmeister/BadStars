extends Super

export var distance = 100

export var noGoColor = Color()
export var goColor = Color()

func _ready():
	$Space/Wall.visible = false
	$Aim.position = Vector2(distance, 0)
	$Area.position = Vector2(distance, 0)
	pass
	
remotesync func use(id:int):
	if $Area.get_overlapping_bodies().empty() and not Globals.outOfBounds($Area.global_position):
		emit_signal("charged", false)
		charged = false
		charge = 0
		get_parent().ui.setSuperCharge(0)
		if emitMessage:
			Network.rpc("event", Globals.events.SUPER, {"player":get_parent().get_network_master(), "super":superMessage})
		rpc("super", id)
	pass
	
remotesync func super(id:int):
	
	$Space/Wall.global_position = global_position + Vector2(distance, 0).rotated(rotation)
	$Space/Wall.global_rotation = global_rotation
	makeWall(true)
	if get_parent().is_network_master():
		$Time.start()
	
	pass
	
remotesync func aim(dir:float):
	
	rotation = dir
	
	pass
	
func aimVisible(val:bool):
	
	if val:
		$Aim.visible = true
		if $Area.get_overlapping_bodies().empty() and not Globals.outOfBounds($Area.global_position):
			$Aim.modulate = goColor
		else:
			$Aim.modulate = noGoColor
	else:
		$Aim.visible = false
	pass
	
remotesync func makeWall(val:bool):
	
	if val:
		
		$Space/Wall.visible = true
		$Space/Wall/Wall/CollisionShape2D.disabled = false
		
	else:
		$Space/Wall.visible = false
		$Space/Wall/Wall/CollisionShape2D.disabled = true
	
	pass


func _on_Time_timeout():
	rpc("makeWall", false)
