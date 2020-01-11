extends Node2D

class_name Super

signal charged(val)

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
			emit_signal("charged", true)
		
		pass
	
	pass
	
remotesync func aim(dir:float):
	
	rotation = dir
	
	pass
	
func aimVisible(val:bool):
	
	pass
	
remotesync func use(id:int):
	emit_signal("charged", false)
	charged = false
	charge = 0
	get_parent().ui.setSuperCharge(0)
	rpc("super", id)
	pass
	
remotesync func super(id:int):
	
	pass

