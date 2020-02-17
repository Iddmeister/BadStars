extends Node2D

class_name Super

signal charged(val)

export var maxCharge = 100
export var damageMultiplier:float = 1
export var emitMessage = true
export var superMessage = "used Super"
onready var charge = 0
var charged = false

func _ready():
	pass
	
func addCharge(damage:int):
	
	charge += (damage*damageMultiplier)
	
	if charge >= maxCharge:
		
		charge = maxCharge
		rpc_id(1, "updateServerCharge", charge)
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
	rpc_id(1, "updateServerCharge", charge)
	get_parent().ui.setSuperCharge(0)
	rpc("super", id)
	if emitMessage:
		Network.rpc("event", Globals.events.SUPER, {"player":get_parent().get_network_master(), "super":superMessage})
	pass
	
remote func updateSeverCharge(c:int):
	charge = c
	
remotesync func super(id:int):
	
	pass
	
func playerDied():
	
	pass

