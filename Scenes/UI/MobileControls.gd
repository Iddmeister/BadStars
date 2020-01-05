extends Control

export var joystickRadius = 100
export var deadZoneRadius = 30

export var LbufferTouch = 0
export var RbufferTouch = 0

var leftStickGrabbed = false
var rightStickGrabbed = false
var superGrabbed = false

var shot = false
var autoaim = false
var deadzoned = false

var autoaimTimeUp = true

var leftStickAxis = Vector2()
var rightStickAxis = Vector2()

func _ready():
	pass
	
func _draw() -> void:
	
	draw_circle($LeftStick.position, joystickRadius, Color(0.5, 1, 0, 0.7))
	draw_circle($RightStick.position, joystickRadius, Color(1, 0, 0.2, 0.7))
	draw_circle($RightStick.position, deadZoneRadius, Color(1, 0, 0.2, 0.7))
	
func _process(delta: float) -> void:
	
	Globals.rightStickAxis = rightStickAxis
	Globals.leftStickAxis = leftStickAxis
	
	pass
	
func _input(event: InputEvent) -> void:
	
	if leftStickGrabbed:
		LbufferTouch = 1000
	else:
		LbufferTouch = 0
		
	if rightStickGrabbed:
		RbufferTouch = 1000
	else:
		RbufferTouch = 0
		
	
	if event is InputEventScreenTouch:
		
		if ((event.position - $LeftStick.global_position).length() <= joystickRadius+LbufferTouch) and event.position.x <= 512:
			
			if event.is_pressed():
				leftStickAxis = (event.position - $LeftStick.global_position).normalized()
				leftStickGrabbed = true
			else:
				leftStickGrabbed = false
				$LeftStick/Stick.position = Vector2(0, 0)
				leftStickAxis = Vector2(0, 0)
					
				
		if ((event.position - $RightStick.global_position).length() <= joystickRadius+RbufferTouch) and event.position.x > 512:
			
			
			if event.is_pressed():
				deadzoned = false
				rightStickAxis = (event.position - $RightStick.global_position).normalized()
				rightStickGrabbed = true
				$AutoaimTimer.start()
				autoaimTimeUp = false
				
			else:
				if not autoaimTimeUp:
					autoaim = true
					rightStickGrabbed = false
					$RightStick/Stick.position = Vector2(0, 0)
					rightStickAxis = Vector2(0, 0)
				else:
					if not deadzoned:
						shot = true
					rightStickGrabbed = false
					$RightStick/Stick.position = Vector2(0, 0)
					rightStickAxis = Vector2(0, 0)
				
	
	elif event is InputEventScreenDrag:
		
		if ((event.position - $LeftStick.global_position).length() <= joystickRadius+LbufferTouch and leftStickGrabbed) and event.position.x <= 512:
		
			$LeftStick/Stick.position = (event.position - $LeftStick.global_position).clamped(joystickRadius)
			leftStickAxis = (event.position - $LeftStick.global_position).normalized()

			
		
		if ((event.position - $RightStick.global_position).length() <= joystickRadius+RbufferTouch and rightStickGrabbed) and event.position.x > 512:
			
			
			$RightStick/Stick.position = (event.position - $RightStick.global_position).clamped(joystickRadius)
			rightStickAxis = (event.position - $RightStick.global_position).normalized()
			
			if (event.position - $RightStick.global_position).length() > deadZoneRadius:
				deadzoned = false
			else:
				deadzoned = true
				

		
	pass
	



func _on_AutoaimTimer_timeout() -> void:
	autoaimTimeUp = true
