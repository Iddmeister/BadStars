extends Effect

func _ready():
	pass
	
func play():
	
	if not $Puff.emitting:
		$Puff.emitting = true
		
func stop():
	
	$Puff.emitting = false
