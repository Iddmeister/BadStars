extends Super

export var leechAmount = 70

func _ready():
	$Aim.visible = false
	pass
	
func aimVisible(val:bool):
	$Aim.visible = val
	pass
	
remotesync func super(id:int):
	
	if not $Bits.emitting:
		$Bits.emitting = true
	
	if get_parent().is_network_master():
		
		for body in $Range.get_overlapping_bodies():
			
			if body.is_in_group("Player"):
				if not body == get_parent():
					
					body.rpc("hit", leechAmount, get_parent().get_network_master())
					get_parent().health += leechAmount
					if get_parent().health > get_parent().maxHealth:
						get_parent().health = get_parent().maxHealth
					get_parent().ui.setHealth(get_parent().health)
					
				
				pass
					
		
		pass
	
	pass
