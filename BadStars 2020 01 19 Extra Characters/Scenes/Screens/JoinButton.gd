extends Button

var ip:String

func _ready():
	pass
	
func setInfo(gameName, ipAd):
	
	text = gameName + " : " + ipAd
	ip = ipAd
	
	pass


func _on_JoinButton_pressed():
	disabled = true
	Network.join(ip)