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
		draw_line(Vector2(0, 0), bear.global_position, lineColour, lineWidth)
		
	pass


remotesync func super(id:int):
	info = {}
	on = true
	bear.rpc("place", global_position)
	pass
	
func initialize():
	bear = ObjectPool.pools[get_parent().get_network_master()]["minions"][0]
	pass
