extends Node2D

signal charged()

export var maxCharge = 100
export var damageMultiplier:float = 1
onready var charge = 0
var charged = false

func _ready():
	pass
	
func addCharge(damage:int):
	
	charge += (damage*damageMultiplier)
	
	if charge >= maxCharge:
		
		charge = maxCharge
		if not charged:
			charged = true
			emit_signal("charged")
		
		pass
	
	pass

