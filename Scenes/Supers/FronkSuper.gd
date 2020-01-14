extends Super

export var damage = 200

func _ready():
	._ready()
	$AimLine.visible = false
	$AimLine.add_point(Vector2(0, 0))
	$AimLine.add_point(Vector2($Range/CollisionShape2D.shape.extents.x*2, 0))

remotesync func aim(dir:float):
	
	rotation = dir
	
	pass
	
func aimVisible(val:bool):
	
	$AimLine.visible = val
	
	pass
	
remotesync func super(id:int):
	
	$Animation.play("Slam")
	
	if get_parent().is_network_master():
		
		for body in $Range.get_overlapping_bodies():
			
			if body.is_in_group("Shootable"):
			
				if not body.is_in_group("Ally"+String(id)):
					
					body.rpc("hit", damage, id, true)
					
					pass
			
			pass
		
		pass
	
	pass

