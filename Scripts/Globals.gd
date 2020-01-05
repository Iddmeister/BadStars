extends Node

enum characters {CLOT, YEETA}

var mobile = false

var characterInfo = {
	
	characters.CLOT:{"poolSize":30, "bulletPath":"res://Scenes/Bullets/ClotBullet.tscn"},
	characters.YEETA:{"poolSize":30, "bulletPath":"res://Scenes/Bullets/Bullet.tscn"},
	
	}
	
var leftStickAxis = Vector2()
var rightStickAxis = Vector2()

func _ready() -> void:
	
	if OS.get_name() == "Android" or OS.get_name() == "iOS":
		mobile = true
		
	#mobile = true
		
	
	pass
