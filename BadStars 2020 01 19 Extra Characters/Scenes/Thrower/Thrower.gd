extends Node2D

class_name Thrower

signal reloaded(ammo)


export var maxAmmo = 3
export var maxDistance = 1000
export var aimWidth = 20
export var areaDiam:float = 5
onready var ammo = maxAmmo

var distance = 0

var canShoot = true

func _ready():
	drawAim()
	$Aim.visible = false

	pass
	
remotesync func shoot(id:int, poolIndex:int):
	
	createBullet(id, poolIndex)
	
	pass
	
func createBullet(id:int, poolIndex:int, direction:float=global_rotation, pos:Vector2=$Muzzle.global_position):
	
	var t = ObjectPool.pools[id].bullets[poolIndex]
	t.global_position = pos
	t.distance = distance
	t.enable()
	t.rpc("throw",direction)
	
	pass
	
func aim(do:bool):
	
	$Aim.visible = do
	$Area.visible = do
	distance = min(Globals.playerToMouse.length(), maxDistance)
	drawAim()
	
	pass
	
func drawAim():
	
	$Aim.polygon = PoolVector2Array([$Muzzle.position-Vector2(0, aimWidth/2), $Muzzle.position+Vector2(distance, 0)-Vector2(0, aimWidth/2), $Muzzle.position+Vector2(distance, 0)+Vector2(0, aimWidth/2), $Muzzle.position+Vector2(0, aimWidth/2)])
	$Area.position = Vector2(distance, 0)
	$Area.scale = Vector2(areaDiam/32, areaDiam/32)
	pass
	

func _on_Cooldown_timeout():
	canShoot = true


func _on_Reload_timeout():
	if not ammo == maxAmmo:
		ammo += 1
		emit_signal("reloaded", ammo)
		if not ammo == maxAmmo:
			$Reload.start()
