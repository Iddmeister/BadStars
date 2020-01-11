extends Control

var skip = true

func _ready():
	if skip:
		get_tree().change_scene("res://Scenes/Screens/MainMenu.tscn")
	pass


func _on_Delay_timeout():
	get_tree().change_scene("res://Scenes/Screens/MainMenu.tscn")
