extends Button

var ip:String

func _ready():
	pass
	
func setInfo(info):
	
	text = info.name + " : " + info.ip + "  Players: " + String(info.players)
	ip = info.ip
	
	pass


func _on_JoinButton_pressed():
	disabled = true
	Network.join(ip)
