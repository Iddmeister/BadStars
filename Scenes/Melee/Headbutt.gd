extends Melee

export var headMoveDist = 300
export var speed:float = 1

remotesync func shoot(id:int, irrelevantPoolIndex:int):
	
	get_parent().get_node("Sprite").visible = false
	get_parent().invincible = true
	get_parent().rpc("freeze", true)
	$Space/Head.visible = true
	$Move.interpolate_property($Space/Head, "global_position", global_position, global_position+Vector2(headMoveDist, 0).rotated(rotation), speed, Tween.TRANS_SINE, Tween.EASE_IN, 0)
	$Move.start()
	
	yield($Move, "tween_completed")
	.shoot(id, irrelevantPoolIndex)
	$Move.interpolate_property($Space/Head, "global_position", null, global_position, speed, Tween.TRANS_SINE, Tween.EASE_IN, 0)
	$Move.start()
	yield($Move, "tween_completed")
	$Space/Head.visible = false
	get_parent().rpc("freeze", false)
	get_parent().get_node("Sprite").visible = true
	get_parent().invincible = false
	
	pass


