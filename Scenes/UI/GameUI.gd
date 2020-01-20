extends Control

class_name gameUI

var maxAmmo:int

func _ready():
	pass
	
func setupUI(maxHealth:int, maxA:int, maxCharge:int):
	
	$Bars/Health.max_value = maxHealth
	$Bars/Health.value = maxHealth
	$Bars/Health/AccurateAmount.text = String(maxHealth)
	$Bars/Super.max_value = maxCharge
	
	maxAmmo = maxA
	$Ammo.text = "Ammo: " + String(maxAmmo) + "/" + String(maxAmmo)
	
	pass
	
func setSuperCharge(charge:int):
	
	$Bars/Super.value = charge
	
	pass
	
func setHealth(health:int):
	
	$Bars/Health.value = health
	$Bars/Health/AccurateAmount.text = String(health)
	
	pass
	
func setAmmo(ammo:int):
	$Ammo.text = "Ammo: " + String(ammo) + "/" + String(maxAmmo)
	pass


func _on_Disconnect_pressed():
	if get_tree().is_network_server():
		Network.disconnectServer()
	else:
		Network.disconnectedFromHost()


func _on_Pause_pressed():
	$PauseMenu.popup()
