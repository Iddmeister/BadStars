extends Control

func _ready():
	pass


func _on_Delay_timeout():
	get_tree().change_scene("res://Scenes/Screens/MainMenu.tscn")
