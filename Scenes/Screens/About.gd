extends Control

func _ready():
	pass


func _on_GitHub_pressed():
	OS.shell_open("https://github.com/Iddmeister/BadStars/")


func _on_Back_pressed():
	get_tree().change_scene("res://Scenes/Screens/MainMenu.tscn")
