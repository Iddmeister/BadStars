extends Control

func _ready():
	pass


func _on_Stick_input_event(viewport, event:InputEvent, shape_idx):
	
	if event is InputEventScreenDrag:
		
		$LeftStick/Stick.position = event.position
	
	pass