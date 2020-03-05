extends "res://Scenes/Supers/YeetaSuper.gd"

export var lineColour:Color
export var lineWidth = 5
var target:Player

remote var info = {}

remotesync var on = false


func _draw():
	if on:
		drawInfo()
	
	pass
	
remotesync func aim(dir:float):
	
	#rotation = dir
	
	pass
	
func drawInfo():
	for player in info.keys():
		draw_line(Vector2(0, 0), target.position-global_position, lineColour, lineWidth)
		
	pass

func findTarget():
	
	var closest:Player
	
	for player in get_tree().get_nodes_in_group("Player"):
		
		if not player.get_network_master() == get_parent().get_network_master() and not player.is_in_group("Ally"):
		
			if not closest:
				closest = player
				continue
			else:
				if global_position.distance_to(player.global_position) < global_position.distance_to(closest.global_position):
					closest = player
				
	target = closest

remotesync func super(id:int):
	info = {}
	findTarget()
	on = true
	bear.rpc("place", global_position)
	pass
	
func initialize():
	bear = ObjectPool.pools[get_parent().get_network_master()]["minions"][0]
	pass
