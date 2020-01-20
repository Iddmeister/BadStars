extends "res://Scenes/Bullets/Bullet.gd"

export var poisonDamage = 10
export var poisionLength = 3

func hitPlayer(body):
	
	body.rpc("poison", poisonDamage, poisionLength, id)
	
	pass
	
