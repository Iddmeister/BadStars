tool

extends StaticBody2D

export(String, "Blue", "Red", "None") var team = "None"

var towerTextures = [preload("res://Graphics/Objects/BLUE TEAM TOWER.png"), preload("res://Graphics/Objects/RED TEAM TOWER.png"), preload("res://Graphics/Objects/NeutralTower.png")]

export var damage = 10

export var health = 400


func _ready():
	
	$HitDelay.start()
	
	if team == "Blue":
		$Sprite.texture = towerTextures[0]
	elif team == "Red":
		$Sprite.texture = towerTextures[1]
	elif team == "None":
		$Sprite.texture = towerTextures[2]
	
	pass

remotesync func hit(dmg, id, super:bool=false):
	health -= dmg
	if health <= 0:
		rpc("destroy")

	pass
	

remotesync func destroy():

	visible = false
	$CollisionShape2D.set_deferred("disabled", true)
	$Range/CollisionShape2D.set_deferred("disabled", true)

	pass
	
func damageAroundTower():
	
	for body in $Range.get_overlapping_bodies():
		
		if body.is_in_group("Player") and not body.is_in_group(team):
			
			body.rpc("hit", damage, 1)
	
	pass


func _on_HitDelay_timeout():
	damageAroundTower()
