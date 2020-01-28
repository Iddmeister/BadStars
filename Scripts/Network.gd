extends Node

const PORT = 2500
const MAX_PLAYERS = 10

signal allPlayersReady()

signal eventHappened(text)

var searchPeer = PacketPeerUDP.new()

var broadcastAddress = "255.255.255.255"

var gameStarted = false

var playerInfo = {
	
	"name":"EpicDude54",
	"character":Globals.characters.SHMELLY,
	"team":"Blue",
	"ready":false,
	
	}
	
var players = {}

var joinableGames = {}

var broadcastTimer = Timer.new()

var starting = false

var currentMap = "Basic"

var matchStats = {"places":[], "players":{}, "graph":{"start":0, "end":0, "points":[]}}

remotesync var playersAlive = 0



func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	add_child(broadcastTimer)
	pass

func host(gameName:String):
	
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(PORT, MAX_PLAYERS)
	get_tree().network_peer = peer
	
	searchPeer.set_dest_address(broadcastAddress, PORT)
	searchPeer.put_var([gameName, IP.get_local_addresses()[1]])
	get_tree().connect("network_peer_connected", self, "playerConnected")
	get_tree().connect("network_peer_disconnected", self, "playerDisconnected")
	
	broadcastTimer.wait_time = 2
	broadcastTimer.connect("timeout", self, "sendBroadcast", [gameName])
	broadcastTimer.start()
	
	players[1] = playerInfo
	
	pass


func join(ip:String):
	
	searchPeer.close()
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client(ip, PORT)
	get_tree().network_peer = peer
	get_tree().connect("connected_to_server", self, "connectedToHost")
	get_tree().connect("connection_failed", self, "disconnectedFromHost")
	get_tree().connect("server_disconnected", self, "disconnectedFromHost")
	joinableGames = {}
	
	pass
	
	
func find():
	
	searchPeer.set_dest_address(broadcastAddress, PORT)
	if not searchPeer.is_listening():
		searchPeer.listen(PORT)
	
	pass
	
	
func _process(delta):
	
	
	if searchPeer.is_listening():
		
		var packet = searchPeer.get_var()
		
		if packet:
			joinableGames[packet[0]] = packet[1]
			
	if starting:
		if get_tree().network_peer:
			
			if get_tree().is_network_server():
				
					
				var allReady = true
				
				for player in players.keys():
					
					if not players[player].ready:
						allReady = false
						break
						
				if allReady:
					
					emit_signal("allPlayersReady")
					
					pass
			
			
	
	pass
	
func sendBroadcast(gameName:String):
	searchPeer.set_dest_address(broadcastAddress, PORT)
	searchPeer.put_var([gameName, IP.get_local_addresses()[1]])
	pass
	
func connectedToHost():
	
	get_tree().change_scene("res://Scenes/Screens/JoinScreen.tscn")
	
	pass
	
remote func sendInfoToServer():
	rpc_id(1, "addPlayerInfo", get_tree().get_network_unique_id(), playerInfo)
	pass
	
func disconnectedFromHost():
	get_tree().paused = true
	ObjectPool.clearAllPools()
	yield(ObjectPool, "poolCleared")
	get_tree().disconnect("connected_to_server", self, "connectedToHost")
	get_tree().disconnect("connection_failed", self, "disconnectedFromHost")
	get_tree().disconnect("server_disconnected", self, "disconnectedFromHost")
	get_tree().network_peer = null
	players = {}
	get_tree().change_scene("res://Scenes/Screens/MainMenu.tscn")
	get_tree().paused = false
	matchStats = {"places":[], "players":{}, "graph":{"start":0, "end":0, "points":[]}}
	pass
	
	
func playerConnected(id:int):
	
	rpc_id(id, "sendInfoToServer")
	
	pass
	
func playerDisconnected(id:int):
	
	players.erase(id)
	
	pass
	
remote func addPlayerInfo(id:int, info:Dictionary):
	players[id] = info
	rpc("updatePlayersInfo", players)
	pass
	
remote func updatePlayersInfo(info:Dictionary):
	
	players = info
	
	pass
	
func disconnectServer():
	get_tree().paused = true
	ObjectPool.clearAllPools()
	yield(ObjectPool, "poolCleared")
	broadcastTimer.stop()
	get_tree().network_peer = null
	get_tree().disconnect("network_peer_connected", self, "playerConnected")
	get_tree().disconnect("network_peer_disconnected", self, "playerDisconnected")
	broadcastTimer.disconnect("timeout", self, "sendBroadcast")
	players = {}
	get_tree().change_scene("res://Scenes/Screens/MainMenu.tscn")
	get_tree().paused = false
	matchStats = {"places":[], "players":{}, "graph":{"start":0, "end":0, "points":[]}}
	pass
	
remote func readyPlayer(id:int):
	
	players[id].ready = true
	
	pass
	
remotesync func startGame(gameMode=Globals.gameModes["Bad Royale"], map="Basic"):
	
	rset("playersAlive", players.keys().size())
	
	for key in players.keys():
		
		matchStats.players[players[key].name] = {"kills":0}
	
	currentMap = map
	
	if get_tree().is_network_server():
		broadcastTimer.stop()
		searchPeer = PacketPeerUDP.new()
		
		matchStats.graph.start = OS.get_ticks_msec()
	
	get_tree().paused = true
	Globals.currentGameMode = gameMode
	get_tree().change_scene("res://Scenes/GameModes/World.tscn")
	starting = true
	
	pass
	
remotesync func event(type:int, info:Dictionary, important=false):
	
	if type == Globals.events.KILL:
		
		emit_signal("eventHappened", players[info.killer].name + " " + info.method + " " + players[info.killed].name, important)
		
	elif type == Globals.events.SUPER:
		
		emit_signal("eventHappened", players[info.player].name + " " + info.super, important)
		
	elif type == Globals.events.MESSAGE:
		emit_signal("eventHappened", info.message, important)
	
	pass
	
	
master func addKill(player:String):
	matchStats.players[player].kills += 1
	playersAlive -= 1
	rset("playersAlive", playersAlive)
	pass
	
master func addGraphPoint(damage:int):
	
	matchStats.graph.points.append({"damage":damage, "time":OS.get_ticks_msec()})
	
	pass
	
remotesync func endGame(stats):
	matchStats = stats
	ObjectPool.clearAllPools()
	if Globals.currentGameMode == "Bad Royale":
		get_tree().change_scene("res://Scenes/Screens/MatchStats.tscn")
	else:
		get_tree().change_scene("res://Scenes/Screens/TeamMatchStats.tscn")
	pass
	
	
remotesync func kick():
	
	disconnectedFromHost()
	
	pass
