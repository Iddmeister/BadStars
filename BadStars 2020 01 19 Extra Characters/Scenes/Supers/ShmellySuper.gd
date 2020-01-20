extends Super

export var damage = 10

var poisoning = false

var pId = 0

func _ready():
	pass
	
remotesync func super(id:int):
	pId = id
	enablePoison(true)
	if get_tree().is_network_server():
		$Time.start()
	pass
	
remotesync func aim(dir:float):
	
	#rotation = dir
	
	pass
	
remotesync func enablePoison(val:bool):
	poisoning = val
	if val:
		$Sprite.visible = true
		if get_tree().is_network_server():
			$HitDelay.start()
	else:
		$Sprite.visible = false
		if get_tree().is_network_server():
			$HitDelay.stop()
	
	pass


func _on_Time_timeout():
	rpc("enablePoison", false)


func _on_HitDelay_timeout():
	for body in $Range.get_overlapping_bodies():
		if not body.is_in_group("Ally"+String(get_parent().get_network_master())):
			body.rpc("hit", damage, pId, false)
