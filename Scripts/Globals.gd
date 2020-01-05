extends Node

enum characters {CLOT, YEETA, SHMELLY}

var mobile = false

var inGame = false

var characterInfo = {
	
	characters.CLOT:{"poolSize":40, "bulletPath":"res://Scenes/Bullets/ClotBullet.tscn", "playerPath":"res://Scenes/Characters/Clot.tscn"},
	characters.SHMELLY:{"poolSize":50, "bulletPath":"res://Scenes/Bullets/ShmellyBullet.tscn", "playerPath":"res://Scenes/Characters/Shmelly.tscn"},
	characters.YEETA:{"poolSize":30, "bulletPath":"res://Scenes/Bullets/Bullet.tscn"},
	
	}
	
var leftStickAxis = Vector2()
var rightStickAxis = Vector2()

func _ready() -> void:
	
	if OS.get_name() == "Android" or OS.get_name() == "iOS":
		mobile = true
		
	#mobile = true
		
	
	pass
