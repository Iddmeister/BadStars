extends Control

export var joystickRadius = 100
export var superStickRadius = 70
export var deadZoneRadius = 30

export var LbufferTouch = 0
export var RbufferTouch = 0
export var SuperBuffer = 0

var leftStickGrabbed = false
var rightStickGrabbed = false
var superGrabbed = false

var shot = false
var superShot = false
var autoaim = false
var deadzoned = false

var showSuperVar = false

var autoaimTimeUp = true

var leftStickAxis = Vector2()
var rightStickAxis = Vector2()
var superStickAxis = Vector2()
var released = true

func _ready():
	pass
	
func showSuper(val:bool):
	
	showSuperVar = val
	update()
	$SuperStick.visible = val
	
	pass
	
func _draw() -> void:
	
	draw_circle($LeftStick.position, joystickRadius, Color(0.5, 1, 0, 0.7))
	draw_circle($RightStick.position, joystickRadius, Color(1, 0, 0.2, 0.7))
	draw_circle($RightStick.position, deadZoneRadius, Color(1, 0, 0.2, 0.7))
	if showSuperVar:
		draw_circle($SuperStick.position, superStickRadius, Color(1, 1, 0, 0.7))
		draw_circle($SuperStick.position, deadZoneRadius, Color(1, 1, 0, 0.7))
	
func _process(delta: float) -> void:
	
	Globals.rightStickAxis = rightStickAxis
	Globals.leftStickAxis = leftStickAxis
	Globals.superStickAxis = superStickAxis
	
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
		
	if superGrabbed:
		SuperBuffer = 300
	else:
		SuperBuffer = 0
		
	
	if event is InputEventScreenTouch or event is InputEventMouseButton:
		
		if ((event.position - $LeftStick.global_position).length() <= joystickRadius+LbufferTouch) and event.position.x <= 512:
			
			if event.is_pressed():
				leftStickAxis = (event.position - $LeftStick.global_position).normalized()
				leftStickGrabbed = true
			else:
				leftStickGrabbed = false
				$LeftStick/Stick.position = Vector2(0, 0)
				leftStickAxis = Vector2(0, 0)
					
				
		if ((event.position - $RightStick.global_position).length() <= joystickRadius+RbufferTouch) and event.position.x > 512 and not superGrabbed:
			
			
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
					if released:
						$Release.start()
						released = false
						if not deadzoned:
							shot = true
						rightStickGrabbed = false
						$RightStick/Stick.position = Vector2(0, 0)
						rightStickAxis = Vector2(0, 0)
					
		if showSuperVar:
					
			if ((event.position - $SuperStick.global_position).length() <= superStickRadius+SuperBuffer) and not rightStickGrabbed and event.position.x > 400:
				
				
				if event.is_pressed():
					deadzoned = false
					superStickAxis = (event.position - $SuperStick.global_position).normalized()
					superGrabbed = true
					
				else:
					if released:
						$Release.start()
						released = false
						if not deadzoned:
							superShot = true
						superGrabbed = false
						$SuperStick/Stick.position = Vector2(0, 0)
						superStickAxis = Vector2(0, 0)
				
	
	elif event is InputEventScreenDrag or event is InputEventMouseMotion:
		
		if ((event.position - $LeftStick.global_position).length() <= joystickRadius+LbufferTouch and leftStickGrabbed) and event.position.x <= 512:
		
			$LeftStick/Stick.position = (event.position - $LeftStick.global_position).clamped(joystickRadius)
			leftStickAxis = (event.position - $LeftStick.global_position).normalized()

			
		
		if ((event.position - $RightStick.global_position).length() <= joystickRadius+RbufferTouch and rightStickGrabbed) and event.position.x > 512 and not superGrabbed:


			$RightStick/Stick.position = (event.position - $RightStick.global_position).clamped(joystickRadius)
			rightStickAxis = (event.position - $RightStick.global_position).normalized()

			if (event.position - $RightStick.global_position).length() > deadZoneRadius:
				deadzoned = false
			else:
				deadzoned = true
				
		if showSuperVar:
				
			if ((event.position - $SuperStick.global_position).length() <= superStickRadius+SuperBuffer and superGrabbed and not rightStickGrabbed ):
				
				
				$SuperStick/Stick.position = (event.position - $SuperStick.global_position).clamped(superStickRadius)
				superStickAxis = (event.position - $SuperStick.global_position).normalized()
				
				if (event.position - $SuperStick.global_position).length() > deadZoneRadius:
					deadzoned = false
				else:
					deadzoned = true
				

		
	pass
	



func _on_AutoaimTimer_timeout() -> void:
	autoaimTimeUp = true


func _on_Release_timeout():
	released = true
