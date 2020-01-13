extends Node

enum characters {CLOT, YEETA, SHMELLY, SALMON, ELSCRIMO, WILL, BARREL, POKO, THRIO, JOKER, BALD, MAGPIE, FRONK}

enum events {KILL, SUPER, MESSAGE}

var killLines = ["destroyed", "rekt", "eliminated", "took out"]

var mobile = false

var bounds = Vector2(2144, 1984)

var characterInfo = {
	
	characters.CLOT:{"poolSize":40, "bulletPath":"res://Scenes/Bullets/ClotBullet.tscn", "playerPath":"res://Scenes/Characters/Clot.tscn"},
	characters.SHMELLY:{"poolSize":50, "bulletPath":"res://Scenes/Bullets/ShmellyBullet.tscn", "playerPath":"res://Scenes/Characters/Shmelly.tscn"},
	characters.YEETA:{"poolSize":30, "bulletPath":"res://Scenes/Bullets/Bullet.tscn"},
	characters.SALMON:{"poolSize":10, "bulletPath":"res://Scenes/Bullets/UnoCard.tscn", "playerPath":"res://Scenes/Characters/Salmon.tscn"},
	characters.ELSCRIMO:{"poolSize":0, "bulletPath":"", "playerPath":"res://Scenes/Characters/ElScrimo.tscn"},
	characters.WILL:{"poolSize":70, "bulletPath":"res://Scenes/Bullets/GenieBall.tscn", "playerPath":"res://Scenes/Characters/Will.tscn", "effects":["res://Scenes/Effects/WillTeleport.tscn", "res://Scenes/Effects/WillTeleport.tscn"]},
	characters.BARREL:{"poolSize":0, "bulletPath":"", "playerPath":"res://Scenes/Characters/Barryl.tscn"},
	characters.POKO: {"poolSize":50, "bulletPath":"Scenes/Bullets/PokoBullet.tscn", "playerPath":"res://Scenes/Characters/Poko.tscn"},
	characters.JOKER: {"poolSize":0, "bulletPath":"", "playerPath":"res://Scenes/Characters/Joker.tscn"},
    characters.BALD:{"poolSize":45, "bulletPath":"res://Scenes/Bullets/BALDBULLET.tscn", "playerPath":"res://Scenes/Characters/BALD.tscn"},
	characters.MAGPIE:{"poolSize":30, "bulletPath":"res://Scenes/Bullets/Feather.tscn", "playerPath":"res://Scenes/Characters/Magpie.tscn"},
	characters.FRONK:{"poolSize":0, "bulletPath":"", "playerPath":"res://Scenes/Characters/Fronk.tscn"},
	characters.THRIO:{"poolSize":7, "bulletPath":"res://Scenes/Bullets/Shuriken.tscn", "playerPath":"res://Scenes/Characters/THRiO.tscn"},
	}
	
var maps = {
	
	"Basic":"res://Scenes/Maps/BasicMap.tscn",
	"BlockBlockBlock":"res://Scenes/Maps/BlockBlockBlock.tscn",
	"No Dummies": "res://Scenes/Maps/NoDummies.tscn",
	"Rings": "res://Scenes/Maps/Rings.tscn",
	
	}
	
var leftStickAxis = Vector2()
var rightStickAxis = Vector2()
var superStickAxis = Vector2()

func _ready() -> void:
	
	if OS.get_name() == "Android" or OS.get_name() == "iOS":
		mobile = true
		
	#mobile = true
		
	
	pass
	
func outOfBounds(pos:Vector2):
	
	if (pos.x > bounds.x or pos.x < 0) or (pos.y > bounds.y or pos.y < 0):
		return true
	else:
		return false
	
	pass
