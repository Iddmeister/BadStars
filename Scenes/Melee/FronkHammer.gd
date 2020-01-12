extends Melee

func drawAim():
	
	$Aim.polygon = $Range/CollisionShape2D.shape.points
	
	pass
	
remotesync func shoot(id:int, irrelevantPoolIndex:int):
	$Animation.play("Slam")
	.shoot(id, irrelevantPoolIndex)
	
	pass

