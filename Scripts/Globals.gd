extends Node

enum characters {CLOT, YEETA, SHMELLY, SALMON, ELSCRIMO, WILL, BARREL, POKO, THRIO, JOKER, BALD, MAGPIE, FRONK, BRICK, KARLMARX, BARELY, FROZONE, PIE, BIT, BIGBRAIN, HARLEM, KOWALSKI, THORN, CAPTURE}


enum events {KILL, SUPER, MESSAGE}

var killLines = ["destroyed", "rekt", "eliminated", "took out", "brutally murdered"]

var mobile = false

var version = "0.6.3"

var bounds = Vector2(2144, 1984)

var localIP:String

onready var currentGameMode = "Bad_Royale"

var characterInfo = {
	
	characters.CLOT:{"name":"Clot", "poolSize":40, "bulletPath":"res://Scenes/Bullets/ClotBullet.tscn", "playerPath":"res://Scenes/Characters/Clot.tscn"},
	characters.SHMELLY:{"name":"Shmelly", "poolSize":50, "bulletPath":"res://Scenes/Bullets/ShmellyBullet.tscn", "playerPath":"res://Scenes/Characters/Shmelly.tscn"},
	characters.YEETA:{"name":"Yeeta", "poolSize":30, "bulletPath":"res://Scenes/Bullets/Bullet.tscn", "playerPath":"res://Scenes/Characters/Yeeta.tscn", "minions":["res://Scenes/Minions/YeetaBear.tscn"]},
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
	characters.THORN:{"name":"THORN", "poolSize":0, "bulletPath":"", "playerPath":"res://Scenes/Characters/spik.tscn"},
	characters.CAPTURE:{"name":"Capture", "poolSize":30, "bulletPath":"res://Scenes/Bullets/CaptureBullet.tscn", "playerPath":"res://Scenes/Characters/Capture.tscn", "minions":["res://Scenes/Minions/CaptureDrone.tscn", "res://Scenes/Minions/CaptureDrone.tscn", "res://Scenes/Minions/CaptureDrone.tscn"]},
	}
var maps = {
	
	"Bad_Royale":{
		"Basic":"res://Scenes/Maps/BadRoyale/BasicMap.tscn",
		"BlockBlockBlock":"res://Scenes/Maps/BadRoyale/BlockBlockBlock.tscn",
		"No_Dummies": "res://Scenes/Maps/BadRoyale/NoDummies.tscn",
		"Rings": "res://Scenes/Maps/BadRoyale/Rings.tscn",
		"Tower_Royale": "res://Scenes/Maps/BadRoyale/Tower Royale.tscn",
		"Tower_Of_London":"res://Scenes/Maps/BadRoyale/TowerOfLondon.tscn",
		},
		
	"Team_Deathmatch":{
		
		"Straights":"res://Scenes/Maps/TeamDeathmatch/Straights.tscn",
		"No_Man's_Land":"res://Scenes/Maps/TeamDeathmatch/NoMansLand.tscn",
		"Bits":"res://Scenes/Maps/TeamDeathmatch/Bits.tscn",
		"Towerland":"res://Scenes/Maps/TeamDeathmatch/TowerLand.tscn",
		
		},
		
	"Bad_Ball":{
		
		"Home_Run":"res://Scenes/Maps/BadBall/HomeRun.tscn",
		"Swamp":"res://Scenes/Maps/BadBall/Swamp.tscn",
		
	},
	
	}
	
var gameModes = {
	
	"Bad_Royale":"res://Scenes/GameModes/BadRoyale.tscn",
	"Team_Deathmatch": "res://Scenes/GameModes/TeamDeathmatch.tscn",
	"Bad_Ball":"res://Scenes/GameModes/BadBall.tscn",
	
	}
	
	
var leftStickAxis = Vector2()
var rightStickAxis = Vector2()
var superStickAxis = Vector2()

var playerToMouse = Vector2()

var usingController = false

var device:int

func _ready() -> void:
	
	Input.connect("joy_connection_changed", self, "setController")
	
	if not Input.get_connected_joypads().empty():

		setController(Input.get_connected_joypads()[0], true)

		pass
	
	if OS.get_name() == "Android" or OS.get_name() == "iOS":
		mobile = true
		
	for ip in IP.get_local_addresses():
		
		if ip.begins_with("192"):
			localIP = ip
		
		pass
		
		
	
		
	
	pass
	
func setController(d, c):
	
	if c:
		device = d
		usingController = true
	else:
		usingController = false
	
	pass
	
func outOfBounds(pos:Vector2):
	
	if (pos.x > bounds.x or pos.x < 0) or (pos.y > bounds.y or pos.y < 0):
		return true
	else:
		return false
	
	pass
