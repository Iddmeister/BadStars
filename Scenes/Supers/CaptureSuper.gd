extends "res://Scenes/Supers/YeetaSuper.gd"

export var lineColour:Color
export var lineWidth = 5
var target:Player
var bear2:Minion
var bear3:Minion

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
		draw_line(Vector2(0, 0), bear.global_position, lineColour, lineWidth)
		draw_line(Vector2(0, 0), bear2.global_position, lineColour, lineWidth)
		draw_line(Vector2(0, 0), bear3.global_position, lineColour, lineWidth)
	pass


remotesync func super(id:int):
	info = {}
	on = true
	bear.rpc("place", global_position)
	$Timer.start()
	pass
	
func initialize():
	bear = ObjectPool.pools[get_parent().get_network_master()]["minions"][0]
	bear2 = ObjectPool.pools[get_parent().get_network_master()]["minions"][1]
	bear3= ObjectPool.pools[get_parent().get_network_master()]["minions"][2]
	pass

func _on_Timer_timeout():
	bear2.rpc("place", global_position)
	$Timer2.start()
	pass # Replace with function body.


func _on_Timer2_timeout():
	bear3.rpc("place", global_position)
	pass # Replace with function body.
