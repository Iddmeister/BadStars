extends Super

export var reloadSpeed = 0.2
var defaultSpeed:float

onready var reload:Timer

func _ready():
	call_deferred("setup")
	pass
	
func setup():
	reload = get_parent().weapon.get_node("Reload")
	defaultSpeed = reload.wait_time
	pass

remotesync func super(id:int):
	
	if get_parent().is_network_master():
		
		reload.wait_time = reloadSpeed
		$Time.start()
		
		pass
	
	pass
	


func _on_Time_timeout():
	reload.wait_time = defaultSpeed
