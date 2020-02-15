extends "res://Scenes/Throwables/BarelyFireball.gd"

export var rotateSpeed = 100

remotesync func stepAnim():
	var scaleVal
	if distanceTravelled < 0.5:
		
		scaleVal = max(0.8, distanceTravelled*5)
		
	else:
		scaleVal = max(0.2, (1-distanceTravelled)*5)
	
	$AirSprite.scale = Vector2(scaleVal, scaleVal)
	pass

