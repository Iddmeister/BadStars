extends Node2D

export var maxCharge = 100
export var damageMultiplier:float = 1
onready var charge = 0 setget setCharge
var charged = false setget setCharged

func _ready():
	pass
	
func addCharge(damage:int):
	
	charge += (damage*damageMultiplier)
	
	if charge >= maxCharge:
		
		charge = maxCharge
		charged = true
		
		pass
	
	pass
	
func setCharged(c:bool):
	
	charged = c
	print("Super Charged")
	
	pass
	
func setCharge(c:int):
	charge = c
	pass
