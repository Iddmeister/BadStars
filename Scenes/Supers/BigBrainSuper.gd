extends Super

export var lineColour:Color
export var lineWidth = 5

remote var info = {}

export var font:DynamicFont
export var bigBrainTex:Texture

remotesync var on = false

onready var def = get_parent().get_node("Sprite").texture

func _draw():
	if on:
		drawInfo()
	
	pass
	
remotesync func aim(dir:float):
	
	#rotation = dir
	
	pass
	
func drawInfo():
	
	for player in info.keys():
		
		draw_line(Vector2(0, 0), info[player].position-global_position, lineColour, lineWidth)
		draw_string(font, info[player].position-global_position, "Health: " + info[player].health, lineColour)
		draw_string(font, info[player].position-global_position+Vector2(0, -40), "Super: "+ info[player].superCharge, lineColour)
		
		
		pass
	
	pass

func _process(delta):
	
	if on:
	
		if get_tree().is_network_server():
			
			
			for player in get_tree().get_nodes_in_group("Player"):
				
				if not player.dead and not player.get_network_master() == get_parent().get_network_master():
				
					info[player.name] = {"health": String(player.health), "superCharge":String(int((float(player.super.charge)/float(player.super.maxCharge))*100)), "position":player.global_position}
				
				pass
				
			rset("info", info)
			
	if get_parent().is_in_group("Ally"+String(get_tree().get_network_unique_id())):
		update()
		
	
	
	pass
	
remotesync func super(id:int):
	info = {}
	setSprite(true)
	on = true
	if get_tree().is_network_server():
		$Time.start()
	pass
	
remotesync func setSprite(val:bool):
	
	if val:
		get_parent().get_node("Sprite").texture = bigBrainTex
		get_parent().get_node("Sprite").scale = Vector2(0.5, 0.5)
	else:
		get_parent().get_node("Sprite").texture = def
		get_parent().get_node("Sprite").scale = Vector2(0.7, 0.7)
	
	pass


func _on_Time_timeout():
	rset("on", false)
	rpc("setSprite", false)
