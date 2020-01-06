extends Control

var currentCharacter = 0

var characters = {
	
	Globals.characters.SHMELLY:{"icon":"res://Graphics/Characters/Shmelly.png", "info":"Shmelly: Faster Than Light but generally bad"},
	Globals.characters.CLOT:{"icon":"res://Graphics/Characters/Clot.png", "info":"Clot: Has red hair"},
	Globals.characters.SALMON:{"icon":"res://Graphics/Characters/Salmon.png", "info":"Salmon: ..."},
	
	}

func _ready():
	Network.playerInfo.name = Data.data.playerName
	$CenterContainer/Options/PlayerName.text = Network.playerInfo.name
	setCharacter(characters.keys()[currentCharacter])
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
