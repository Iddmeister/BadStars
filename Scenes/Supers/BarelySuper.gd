extends "res://Scenes/Supers/ShmellySuper.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$ChargedBarely.visible = false
	$Sprite.visible = false
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
remotesync func enablePoison(val:bool):
	poisoning = val
	if val:
		$Sprite.visible = true
		$ChargedBarely.visible = true
		if get_tree().is_network_server():
			$HitDelay.start()
	else:
		$Sprite.visible = false
		$ChargedBarely.visible = false
		if get_tree().is_network_server():
			$HitDelay.stop()
	
	pass

func _on_Time_timeout():
	rpc("enablePoison", false)
	pass
