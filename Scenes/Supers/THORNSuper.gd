extends Super

var defaultSpeed:int
export var speed = 500

func _ready():
	defaultSpeed = get_parent().moveSpeed
	pass
	
remotesync func super(id:int):
	get_parent().moveSpeed = speed
	if get_parent().is_network_master():
		$Time.start()
	pass
	
	
remotesync func resetSpeed():
	get_parent().moveSpeed = defaultSpeed
	pass

	

func _on_Time_timeout():
	rpc("resetSpeed")
	addCharge(selfChargeAmount)
	get_parent().ui.setSuperCharge(charge)

