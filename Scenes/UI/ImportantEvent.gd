extends Label

func _ready():
	pass


func _on_Age_timeout():
	queue_free()
