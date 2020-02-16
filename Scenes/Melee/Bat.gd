extends Melee

export var knockPower = 300

export var knockTime:float = 1


func _ready():
	drawAim()
	$Aim.visible = false
	$Fist.visible = false
	pass
	
remotesync func shoot(id:int, irrelevantPoolIndex:int):
	
	$Animation.play("Punch")
	
	.shoot(id, irrelevantPoolIndex)
	pass
	
func hitPlayer(p:Player):
	if ammo == maxAmmo:
		p.rpc("knockback", Vector2(knockPower, 0).rotated(rotation), knockTime)
	
	pass

func _on_Reload_timeout():
	if not ammo == maxAmmo:
		ammo += 1
		damage = 50
		emit_signal("reloaded", ammo)
		if not ammo == maxAmmo:
			$Reload.start()
		
		if ammo == maxAmmo:
			damage = 100
