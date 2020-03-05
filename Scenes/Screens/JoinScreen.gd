extends Control

func _ready():
	pass

var CanPress = true

func _on_Disconnect_pressed():
	Network.disconnectedFromHost()


func _on_Team_toggled(button_pressed):
	if button_pressed:
		$CenterContainer/VBoxContainer/Team.modulate = Color(1, 0, 0)
		Network.playerInfo.team = "Red" 
		Network.rpc_id(1, "addPlayerInfo", get_tree().get_network_unique_id(), Network.playerInfo)
	else:
		$CenterContainer/VBoxContainer/Team.modulate = Color(0, 0, 1)
		Network.playerInfo.team = "Blue" 
		Network.rpc_id(1, "addPlayerInfo", get_tree().get_network_unique_id(), Network.playerInfo)


func _on_Button_pressed(Canpress):
	if Canpress:
		$Animation.play("Emote")
		$Cooldown.start
		CanPress = false
	pass # Replace with function body.


func _on_Cooldown_timeout(Canpress):
	Canpress = true
	pass # Replace with function body.
