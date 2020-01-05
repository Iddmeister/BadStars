extends Control

func _ready():
	$CenterContainer/Options/PlayerName.text = Network.playerInfo.name
	if Network.playerInfo.character == Globals.characters.CLOT:
		$CenterContainer/Options/Character.selected = 1
	else:
		$CenterContainer/Options/Character.selected = 0
	pass


func _on_Find_Game_pressed():
	Network.find()
	get_tree().change_scene("res://Scenes/Screens/SearchScreen.tscn")


func _on_Host_Game_pressed():
	Network.host(Network.playerInfo.name)
	get_tree().change_scene("res://Scenes/Screens/HostScreen.tscn")
	


func _on_PlayerName_text_changed(new_text):
	Network.playerInfo.name = new_text


func _on_Character_item_selected(ID):
	if ID == 0:
		Network.playerInfo.character = Globals.characters.SHMELLY
	elif ID == 1:
		Network.playerInfo.character = Globals.characters.CLOT
