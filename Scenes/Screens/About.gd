extends Control

func _ready():
	pass


func _on_GitHub_pressed():
	OS.shell_open("https://github.com/Iddmeister/BadStars/")


func _on_Back_pressed():
	get_tree().change_scene("res://Scenes/Screens/MainMenu.tscn")


func _on_Itch_pressed():
	OS.shell_open("https://iddmeister.itch.io/bad-stars")


func _on_Subreddit_pressed():
	OS.shell_open("https://www.reddit.com/r/BadStars/")


func _on_Discord_pressed():
	OS.shell_open("https://discord.gg/gTJadX3")


func _on_Text_meta_clicked(meta):
	OS.shell_open(meta)


func _on_Godot_pressed():
	OS.shell_open("https://godotengine.org/")
