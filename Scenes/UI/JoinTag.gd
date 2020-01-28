extends Control

var id:int

signal kick(id)

func _on_Kick_pressed():
	emit_signal("kick", id)
	
func setName(n:String):
	
	$HBoxContainer/Name.text = n
	
	pass
	
func setTeam(t:String):
	
	if t == "Blue":
		
		$HBoxContainer/Name.modulate = Color(0, 0, 1)
		
	elif t == "Red":
		
		$HBoxContainer/Name.modulate = Color(1, 0, 0)
		
	else:
		$HBoxContainer/Name.modulate = Color(1, 1, 1)
	
	pass
