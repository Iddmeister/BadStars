extends Node2D

class_name Throwable

var distance = 100
export var airTime:float = 1
export (int, "Trans_Linear", "Trans_Sine", "Trans_Quint", "Trans_Quart", "Trans_Quad", "Trans_Expo", "Trans_Elastic", "Trans_Cubic", "Trans_Circ", "Trans_Bounce", "Trans_Back") var transType = 1
export(int, "Ease_In", "Ease_Out", "Ease_In_Out", "Ease_Out_In") var easeType = 0

# Value from 0 to 1
remotesync var distanceTravelled = 0

var enabled = false

var landed = false

var id:int

func _ready():
	pass
	
func _physics_process(delta):
	if get_tree().get_network_unique_id() == id:
		rpc("updatePosition", global_position)
	
remotesync func throw(direction:float):
	landed = false
	if get_tree().get_network_unique_id() == id:
		$Move.interpolate_property(self, "global_position", null, global_position+Vector2(distance, 0).rotated(direction), airTime, transType, easeType, 0)
		$Move.start()
	pass
	
remotesync func land():
	pass
	
remotesync func stepAnim():
	#Animation every step of tween
	pass
	
	
func enable():
	visible = true
	enabled = true
	set_process(true)
	set_physics_process(true)
	pass
	
func disable():
	visible = false
	enabled = false
	call_deferred("properDisable")
	pass
	
func properDisable():
	set_process(false)
	set_physics_process(false)
	
	
remotesync func destroy():
	disable()
	pass
	
remotesync func updatePosition(pos:Vector2):
	global_position = pos
	pass



func _on_Move_tween_step(object, key, elapsed, value):
	if key == ":global_position":
		rset("distanceTravelled", elapsed/airTime)
		rpc("stepAnim")

func _on_Move_tween_completed(object, key):
	if key == ":global_position":
		rpc("land")
