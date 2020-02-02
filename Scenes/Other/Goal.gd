extends Node2D

export(int, "Blue", "Red") var team = 0

signal goalScored(team)

func _on_Area_body_entered(body):
	if is_network_master():
		if body.is_in_group("Ball"):
			emit_signal("goalScored", team)
