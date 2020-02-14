extends Melee

func _ready():
	drawAim()
	$Aim.visible = false
	$Fist.visible = false
	pass
	
remotesync func shoot(id:int, irrelevantPoolIndex:int):
	
	$Animation.play("Punch")
	
	.shoot(id, irrelevantPoolIndex)
	pass
	
func _process(delta):
	print(damage)

func _on_Reload_timeout():
	if not ammo == maxAmmo:
		ammo += 1
		damage = 50
		emit_signal("reloaded", ammo)
		if not ammo == maxAmmo:
			$Reload.start()
		
		if ammo == maxAmmo:
			damage = 100
