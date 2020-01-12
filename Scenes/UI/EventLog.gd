extends Control

export var maxEvents = 5

var eventLabel = preload("res://Scenes/UI/Event.tscn")

func _ready():
	Network.connect("eventHappened", self, "addEvent")
	pass
	
func addEvent(text:String):
	var e  = eventLabel.instance()
	e.text = text
	$Log.add_child(e)
	removeEvents()
	pass
	
func removeEvents():
	
	if $Log.get_child_count() > maxEvents:
		$Log.remove_child($Log.get_children()[0])
		removeEvents()
		pass
	
	pass
