extends Control

var currentCharacter = 0

var characters = {
	
	Globals.characters.SHMELLY:{"icon":"res://Graphics/Characters/Shmelly.png", "info":"Shmelly: Stanks"},
	Globals.characters.CLOT:{"icon":"res://Graphics/Characters/Clot.png", "info":"Clot: Has red hair"},
	Globals.characters.SALMON:{"icon":"res://Graphics/Characters/Salmon.png", "info":"Salmon: ..."},
	Globals.characters.ELSCRIMO:{"icon":"res://Graphics/Characters/ElScrimo.png", "info":"El Scrimo: REEEEEEEEEEEEEEE"},
	Globals.characters.WILL:{"icon":"res://Graphics/Characters/WillSmith.png", "info":"Will Smith: Blue"},
	Globals.characters.BARREL:{"icon":"res://Graphics/Characters/Barryl.png", "info":"Barrel: is barrel"},
	Globals.characters.BALD:{"icon":"res://Graphics/Characters/Bald.png", "info":"Bald: Brexiteer"},
	Globals.characters.POKO:{"icon":"res://Graphics/Characters/Poko.png", "info":"Poko: Buenos Dias"},
	Globals.characters.THRIO:{"icon":"res://Graphics/Characters/THRiO.png", "info":"THRiO: It's a feature, not a bug"},
	Globals.characters.JOKER:{"icon":"res://Graphics/Characters/Joker.png", "info":"Joker: You Wouldn't Get It"},
	Globals.characters.MAGPIE:{"icon":"res://Graphics/Characters/Magpie.png", "info":"Magpie: SHINY SHINY SHINY"},
	Globals.characters.FRONK:{"icon":"res://Graphics/Characters/Fronk.png", "info":"FRONK: ICH BIN FRONK"},
	Globals.characters.KARLMARX:{"icon":"res://Graphics/Characters/KarlMarx.png", "info":"Karl Marx: Communism"},
	Globals.characters.BARELY:{"icon":"res://Graphics/Characters/Barely.png", "info":"Barely: Barely a character"},
	Globals.characters.BRICK:{"icon":"res://Graphics/Characters/Brick.png", "info":"Brick is literally a brick"},
	Globals.characters.FROZONE:{"icon":"res://Graphics/Characters/Frozone.png", "info":"Frozone: Couldn't get the rights to Mr Incredible"},
	Globals.characters.PIE:{"icon":"res://Graphics/Characters/pie-per.png", "info":"PIE: Pie-Per"},
	Globals.characters.BIT:{"icon":"res://Graphics/Characters/Bit.png", "info":"64 Bit: AN arcade cabinet..."},
	Globals.characters.BIGBRAIN:{"icon":"res://Graphics/Characters/BigBrain.png", "info":"Big Brain: Funky Fonky when it’s Chunky Chonky"},
	Globals.characters.YEETA:{"icon":"res://Graphics/Characters/Yeeta.png", "info":"Yeeta: Bears have feelings too"},
	Globals.characters.HARLEM:{"icon":"res://Graphics/Characters/Harlem.png", "info":"Harlem: Wack"},
	Globals.characters.KOWALSKI:{"icon":"res://Graphics/Characters/kowalski2.png", "info":"Kowalski: Analysis "},
	Globals.characters.THORN:{"icon":"res://Graphics/Characters/spik.png", "info":"Thorn: Kinda like a cactus"},
	Globals.characters.CAPTURE:{"icon":"res://Graphics/Characters/Capture.png", "info":"Capture: Are you a robot?"},
}


func _ready():
	Network.playerInfo.name = Data.data.playerName
	Network.playerInfo.team = "Blue"
	$CheckBox.pressed = OS.window_fullscreen
	$CenterContainer/Options/PlayerName.text = Network.playerInfo.name
	currentCharacter = characters.keys().find(int(Data.data["lastPlayed"]))
	setCharacter(characters.keys()[currentCharacter])
	$Version.text = "Version "+Globals.version
	pass


func _on_Find_Game_pressed():
	Network.find()
	get_tree().change_scene("res://Scenes/Screens/SearchScreen.tscn")


func _on_Host_Game_pressed():
	Network.host(Network.playerInfo.name)
	get_tree().change_scene("res://Scenes/Screens/HostScreen.tscn")
	


func _on_PlayerName_text_changed(new_text):
	Network.playerInfo.name = new_text
	Data.data.playerName = new_text
	Data.saveData()




func _on_DirectConnect_pressed():
	Network.join($VBoxContainer/VBoxContainer/IP.text)
	
func setCharacter(key):
	
	$CenterContainer/Options/CharacterSelect/HBoxContainer/Image.texture = load(characters[key].icon)
	$CenterContainer/Options/CharacterSelect/CharacterInfo.text = characters[key].info
	Network.playerInfo.character = key
	Data.data["lastPlayed"] = key
	Data.saveData()
	
	pass


func _on_Left_pressed():
	if not currentCharacter == 0:
		
		currentCharacter-=1
		setCharacter(characters.keys()[currentCharacter])
		
		pass


func _on_Right_pressed():
	if not currentCharacter == characters.keys().size()-1:
		
		currentCharacter+=1
		setCharacter(characters.keys()[currentCharacter])
		pass


func _on_CheckBox_toggled(button_pressed):
	OS.window_fullscreen = button_pressed



func _on_About_pressed():
	get_tree().change_scene("res://Scenes/Screens/About.tscn")


func _on_Random_pressed():
	currentCharacter = rand_range(0, characters.keys().size())
	setCharacter(characters.keys()[currentCharacter])
	pass
