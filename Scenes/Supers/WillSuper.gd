extends Super

export var distance = 300
export var selfChargeAmount = 10

export var noGoColor = Color()
export var goColor = Color()

func _ready():
	$Sprite.position = Vector2(distance, 0)
	$Area.position = Vector2(distance, 0)
	$Sprite.visible = false
	$SelfCharge.start()
	pass
	
remotesync func use(id:int):
	if $Area.get_overlapping_bodies().empty():
		emit_signal("charged", false)
		charged = false
		charge = 0
		get_parent().ui.setSuperCharge(0)
		rpc("super", id)
	pass
	
remotesync func super(id:int):
	
	var ef1 = Effects.effects[get_parent().get_network_master()][0]
	ef1.global_position = global_position
	ef1.show()
	ef1.play()
	if get_parent().is_network_master():
		get_parent().global_position = get_parent().global_position + Vector2(distance, 0).rotated(rotation)
		get_parent().rpc_unreliable("setPosition", global_position)
		
		rpc("secondEffect", global_position)
	
	pass
	
remotesync func secondEffect(pos):
	
	var ef2 = Effects.effects[get_parent().get_network_master()][1]
	ef2.global_position = pos
	ef2.show()
	ef2.play()
	
	pass
	
func aimVisible(val:bool):
	
	if val:
		$Sprite.visible = true
		if $Area.get_overlapping_bodies().empty():
			$Sprite.modulate = goColor
		else:
			$Sprite.modulate = noGoColor
	else:
		$Sprite.visible = false
	
	pass


func _on_SelfCharge_timeout():
	addCharge(selfChargeAmount)
	get_parent().ui.setSuperCharge(charge)
