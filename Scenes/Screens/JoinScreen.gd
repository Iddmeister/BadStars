extends Control

func _ready():
	pass


func _on_Disconnect_pressed():
	Network.disconnectedFromHost()
