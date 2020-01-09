extends StaticBody2D

export var destroyedTexture:AtlasTexture

func _ready():
	pass
	
master func hit(damage:int, id:int, destroy=false):
	if destroy:
		rpc("destroy")
		pass
	
	pass

remotesync func destroy():
	
	$Bits.emitting = true
	$Sprite.texture = destroyedTexture
	remove_from_group("Shootable")
	$CollisionShape2D.set_deferred("disabled", true)
	
	pass
	

