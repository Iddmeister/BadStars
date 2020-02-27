extends Node

enum characters {CLOT, YEETA, SHMELLY, SALMON, ELSCRIMO, WILL, BARREL, POKO, THRIO, JOKER, BALD, MAGPIE, FRONK, BRICK, KARLMARX, BARELY, FROZONE, PIE, BIT, BIGBRAIN, HARLEM, KOWALSKI}


enum events {KILL, SUPER, MESSAGE}

var killLines = ["destroyed", "rekt", "eliminated", "took out"]

var mobile = false

var version = "0.5.6"

var bounds = Vector2(2144, 1984)

var localIP:String

onready var currentGameMode = "Bad Royale"

var characterInfo = {
	
	characters.CLOT:{"name":"Clot", "poolSize":40, "bulletPath":"res://Scenes/Bullets/ClotBullet.tscn", "playerPath":"res://Scenes/Characters/Clot.tscn"},
	characters.SHMELLY:{"name":"Shmelly", "poolSize":50, "bulletPath":"res://Scenes/Bullets/ShmellyBullet.tscn", "playerPath":"res://Scenes/Characters/Shmelly.tscn"},
	characters.YEETA:{"name":"Yeeta", "poolSize":30, "bulletPath":"res://Scenes/Bullets/Bullet.tscn"},
	characters.SALMON:{"name":"Salmon", "poolSize":10, "bulletPath":"res://Scenes/Bullets/UnoCard.tscn", "playerPath":"res://Scenes/Characters/Salmon.tscn"},
	characters.ELSCRIMO:{"name":"El Scrimo", "poolSize":0, "bulletPath":"", "playerPath":"res://Scenes/Characters/ElScrimo.tscn"},
	characters.WILL:{"name":"Will Smith", "poolSize":70, "bulletPath":"res://Scenes/Bullets/GenieBall.tscn", "playerPath":"res://Scenes/Characters/Will.tscn", "effects":["res://Scenes/Effects/WillTeleport.tscn", "res://Scenes/Effects/WillTeleport.tscn"]},
	characters.BARREL:{"name":"Barrel", "poolSize":0, "bulletPath":"", "playerPath":"res://Scenes/Characters/Barryl.tscn"},
	characters.POKO: {"name":"Poko", "poolSize":50, "bulletPath":"Scenes/Bullets/PokoBullet.tscn", "playerPath":"res://Scenes/Characters/Poko.tscn"},
	characters.JOKER: {"name":"Joker", "poolSize":0, "bulletPath":"", "playerPath":"res://Scenes/Characters/Joker.tscn"},
	characters.BALD:{"name":"Bald", "poolSize":45, "bulletPath":"res://Scenes/Bullets/BALDBULLET.tscn", "playerPath":"res://Scenes/Characters/BALD.tscn"},
	characters.MAGPIE:{"name":"Magpie", "poolSize":30, "bulletPath":"res://Scenes/Bullets/Feather.tscn", "playerPath":"res://Scenes/Characters/Magpie.tscn"},
	characters.FRONK:{"name":"Fronk", "poolSize":0, "bulletPath":"", "playerPath":"res://Scenes/Characters/Fronk.tscn"},
	characters.THRIO:{"name":"THRiO", "poolSize":7, "bulletPath":"res://Scenes/Bullets/Shuriken.tscn", "playerPath":"res://Scenes/Characters/THRiO.tscn"},
	characters.BRICK:{"name":"Brick", "poolSize":40, "bulletPath":"res://Scenes/Bullets/BrickBullet.tscn", "playerPath":"res://Scenes/Characters/Brick.tscn"},
	characters.BARELY: {"name":"Barely", "poolSize":10, "bulletPath":"res://Scenes/Throwables/BarelyFireball.tscn", "playerPath":"res://Scenes/Characters/Barely.tscn"},
	characters.KARLMARX: {"name":"Karl Marx", "poolSize":0, "bulletPath":"", "playerPath":"res://Scenes/Characters/KarlMarx.tscn"},
	characters.FROZONE:{"name":"Frozone", "poolSize":20, "bulletPath":"res://Scenes/Bullets/Icicle.tscn", "playerPath":"res://Scenes/Characters/Frozone.tscn"},
	characters.BIT:{"name":"64-Bit", "poolSize":40, "bulletPath":"res://Scenes/Bullets/BitBullet.tscn", "playerPath":"res://Scenes/Characters/Bit.tscn"},
	characters.PIE:{"name":"Pie-Per", "poolSize":40, "bulletPath":"res://Scenes/Bullets/PieBullet.tscn", "playerPath":"res://Scenes/Characters/PIE-PER.tscn"},  
	characters.BIGBRAIN:{"name":"Big Brain", "poolSize":0, "bulletPath":"", "playerPath":"res://Scenes/Characters/BigBrain.tscn"},
	characters.HARLEM: {"name":"Harlem", "poolSize":15, "bulletPath":"res://Scenes/Bullets/Bubble.tscn", "playerPath":"res://Scenes/Characters/Harlem.tscn"},
	characters.KOWALSKI: {"name":"Kowalski", "poolSize":15, "bulletPath":"res://Scenes/Throwables/Kowalski.tscn", "playerPath":"res://Scenes/Characters/Kowalski.tscn"},
}
	
var maps = {
	
	"Bad Royale":{
		"Basic":"res://Scenes/Maps/BadRoyale/BasicMap.tscn",
		"BlockBlockBlock":"res://Scenes/Maps/BadRoyale/BlockBlockBlock.tscn",
		"No Dummies": "res://Scenes/Maps/BadRoyale/NoDummies.tscn",
		"Rings": "res://Scenes/Maps/BadRoyale/Rings.tscn",
		"Tower Royale": "res://Scenes/Maps/BadRoyale/Tower Royale.tscn",
		"Tower Of London":"res://Scenes/Maps/BadRoyale/TowerOfLondon.tscn",
		},
		
	"Team Deathmatch":{
		
		"Straights":"res://Scenes/Maps/TeamDeathmatch/Straights.tscn",
		"No Man's Land":"res://Scenes/Maps/TeamDeathmatch/NoMansLand.tscn",
		"Bits":"res://Scenes/Maps/TeamDeathmatch/Bits.tscn",
		"Towerland":"res://Scenes/Maps/TeamDeathmatch/TowerLand.tscn",
		
		},
		
	"Bad Ball":{
		
		"Home Run":"res://Scenes/Maps/BadBall/HomeRun.tscn",
		"Swamp":"res://Scenes/Maps/BadBall/Swamp.tscn",
		
	},
	
	}
	
var gameModes = {
	
	"Bad Royale":"res://Scenes/GameModes/BadRoyale.tscn",
	"Team Deathmatch": "res://Scenes/GameModes/TeamDeathmatch.tscn",
	"Bad Ball":"res://Scenes/GameModes/BadBall.tscn",
	
	}
	
	
var leftStickAxis = Vector2()
var rightStickAxis = Vector2()
var superStickAxis = Vector2()

var playerToMouse = Vector2()

func _ready() -> void:
	
	if OS.get_name() == "Android" or OS.get_name() == "iOS":
		mobile = true
		
	if OS.get_name() == "Windows":
		localIP = IP.get_local_addresses()[1]
	elif OS.get_name() == "X11":
		localIP = IP.get_local_addresses()[0]
	else:
		localIP = IP.get_local_addresses()[0]
		
	
		
	
	pass
	
func outOfBounds(pos:Vector2):
	
	if (pos.x > bounds.x or pos.x < 0) or (pos.y > bounds.y or pos.y < 0):
		return true
	else:
		return false
	
	pass
