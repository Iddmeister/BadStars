extends Melee

func _ready():
	drawAim()
	$Aim.visible = false
	$Fist.visible = false
	pass
	
remotesync func shoot(id:int, irrelevantPoolIndex:int):
	
	$Animation.play("Punch")
	
	.shoot(id, irrelevantPoolIndex)
