extends Melee

var hasHitPlayer = false

var bodies = []

func _ready():
	get_parent().connect("started", self, "set_process", [true])
	set_process(false)
	pass
	
remotesync func shoot(id:int, irrelevantPoolIndex:int):
	
	pass
	
	
func _process(delta):
	
	if get_parent().is_network_master() and not get_parent().dead:
		
		for body in $Range.get_overlapping_bodies():
			
			if body.is_in_group("Shootable"):
				
				if not body.is_in_group("Ally"+String(get_parent().get_network_master())):
				
					if not hasHitPlayer and not bodies.has(body):
						
						bodies.append(body)
						body.rpc("hit", damage, get_parent().get_network_master())
						hasHitPlayer = true
						$Delay.start()
						
						if body.is_in_group("Player") or body.is_in_group("Dummy"):
							get_tree().get_nodes_in_group("Master"+String(get_parent().get_network_master()))[0].rpc("didDamage", damage)
				
				pass
			
			pass
	
	pass
	
func aim(do:bool):

	
	pass


func _on_Delay_timeout():
	hasHitPlayer = false


func _on_Range_body_exited(body):
	bodies.erase(body)
	pass
