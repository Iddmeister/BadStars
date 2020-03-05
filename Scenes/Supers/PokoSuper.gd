extends Super

export var leechAmount = 70
export var maxLeech = 3

var bodiesLeeched = 0

func _ready():
	$Aim.visible = false
	pass
	
func aimVisible(val:bool):
	$Aim.visible = val
	pass
	
remotesync func super(id:int):
	
	$Animation.play("Whoosh")
	$Eye.emitting = true
	
	if get_parent().is_network_master():
		
		for body in $Range.get_overlapping_bodies():
			
			if bodiesLeeched < maxLeech:
				if body.is_in_group("Player"):
					if not body.is_in_group("Ally"+String(get_parent().get_network_master())):
						
						body.rpc("hit", leechAmount, get_parent().get_network_master())
						get_parent().health += leechAmount
						if get_parent().health > get_parent().maxHealth:
							get_parent().health = get_parent().maxHealth
						get_parent().ui.setHealth(get_parent().health)
						bodiesLeeched += 1
						
					
					pass
		bodiesLeeched = 0
						
		
		pass
	
	pass
