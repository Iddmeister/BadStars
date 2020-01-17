extends "res://Scenes/Melee/Fists.gd"

export var Throw = 300

func _ready():
	$Sprite.position = Vector2(Throw, 0)
	$Range.position = Vector2(Throw, 0)
	$Sprite.visible = false
	pass

func aim(do:bool):
	
	$Sprite.visible = do