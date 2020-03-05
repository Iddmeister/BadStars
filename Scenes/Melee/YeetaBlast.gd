extends Melee

remotesync func shoot(id:int, irrelevantPoolIndex:int):
	$Animation.play("Blast")
	.shoot(id, irrelevantPoolIndex)
	pass
