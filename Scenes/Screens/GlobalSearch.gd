extends Control

var openHosts = {}

func _ready():
	pass


func _on_Connect_pressed():
	
	for c in $HBoxContainer/Servers.get_children():
		c.queue_free()
	
	$HTTPRequest.request($HBoxContainer/Options/VBoxContainer/Host.text, ["passcode: %s" % $HBoxContainer/Options/VBoxContainer/Passcode.text, "type: get"])

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	if result == OK:
		var json = JSON.parse(body.get_string_from_utf8())
		openHosts = json.result
		
		for server in openHosts.keys():
			addServerButton(server, openHosts[server])
		
		
func addServerButton(n:String, ip:String):
	
	var b = Button.new()
	b.name = n
	b.text = n+" : "+ip
	$HBoxContainer/Servers.add_child(b)
	b.connect("pressed", self, "serverSelected", [n])
	
	pass
	
func serverSelected(n:String):
	Network.join(openHosts[n])
	pass


func _on_Back_pressed():
	get_tree().change_scene("res://Scenes/Screens/MainMenu.tscn")
