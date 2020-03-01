extends CanvasLayer

func _ready():
	pass
	
	
func disconnected():
	
	$Main/Animation.play("Disconnected")
	
	pass
	
func serverClosed():
	
	$Main/Animation.play("ServerClosed")
	
	pass
	
func failed():
	
	$Main/Animation.play("Failed")
	
	pass
