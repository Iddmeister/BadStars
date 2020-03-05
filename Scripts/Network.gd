extends Node

const PORT = 2542
const MAX_PLAYERS = 10

signal allPlayersReady()

signal eventHappened(text)

signal killPlayer(id)

var searchPeer = PacketPeerUDP.new()

var broadcastAddress = "255.255.255.255"

var gameStarted = false

var upnpHost:UPNP = UPNP.new()

var playerInfo = {
	
	"name":"EpicDude54",
	"character":Globals.characters.SHMELLY,
	"team":"Blue",
	"ready":false,
	
	}
	
var players = {}

var joinableGames = {}

var timeoutList = {}
var timeout = 70

var searching = false
var broadcasting = false

var starting = false

var currentMap = "Basic"

var matchStats = {"places":[], "players":{}}

remotesync var playersAlive = 0


func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	pass

func host(gameName:String):
	
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(PORT, MAX_PLAYERS)
	get_tree().network_peer = peer
	
	searchPeer.set_broadcast_enabled(true)
	searchPeer.set_dest_address(broadcastAddress, PORT)
	sendBroadcast(playerInfo.name)
	
	get_tree().connect("network_peer_connected", self, "playerConnected")
	get_tree().connect("network_peer_disconnected", self, "playerDisconnected")
	
	
	players[1] = playerInfo
	
	broadcasting = true
	
	pass


func join(ip:String):
	
	searchPeer.close()
	searching = false
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client(ip, PORT)
	get_tree().network_peer = peer
	get_tree().connect("connected_to_server", self, "connectedToHost")
	get_tree().connect("connection_failed", self, "disconnectedFromHost")
	get_tree().connect("server_disconnected", self, "disconnectedFromHost")
	joinableGames = {}
	timeoutList = {}
	
	pass
	
	
func find():
	
	searching = true
	searchPeer.set_dest_address(broadcastAddress, PORT)
	if not searchPeer.is_listening():
		searchPeer.listen(PORT)
	
	pass
	
	
func _process(delta):
	
	
	if searching:
		
		
		if searchPeer.get_available_packet_count() > 0:
		
			var packet = searchPeer.get_var()

			if packet:
				joinableGames[packet.name] = packet
				timeoutList[packet.name] = 0
				
		for game in timeoutList.keys():
			
			timeoutList[game] += 1
			
			if timeoutList[game] >= timeout:
				joinableGames.erase(game)
			
			
			
	elif broadcasting:
		sendBroadcast(playerInfo.name)
		
			
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
	searchPeer.put_var({"name":gameName, "ip":Globals.localIP, "players":players.keys().size()})
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
	matchStats = {"places":[], "players":{}}
	searching = false
	broadcasting = false
	Popups.disconnected()
	pass
	
	
func playerConnected(id:int):
	
	rpc_id(id, "sendInfoToServer")
	
	pass
	
func playerDisconnected(id:int):
	
	players.erase(id)
	emit_signal("killPlayer", id)
	
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
	if upnpHost.get_device_count() > 0:
		upnpHost.delete_port_mapping(Network.PORT)
	get_tree().network_peer = null
	get_tree().disconnect("network_peer_connected", self, "playerConnected")
	get_tree().disconnect("network_peer_disconnected", self, "playerDisconnected")
	players = {}
	get_tree().change_scene("res://Scenes/Screens/MainMenu.tscn")
	get_tree().paused = false
	matchStats = {"places":[], "players":{}}
	searchPeer.close()
	searchPeer = PacketPeerUDP.new()
	joinableGames = {}
	timeoutList = {}
	broadcasting = false
	searching = false
	
	Popups.serverClosed()
	if Twitch.connected:
		Twitch.connected = false
		Twitch.chat("Disconnected, ")
		Twitch.websocket.disconnect_from_host()
		Twitch.leave_channel(Twitch.channel)
	
	pass
	
remote func readyPlayer(id:int):
	
	players[id].ready = true
	
	pass
	
remotesync func startGame(gameMode=Globals.gameModes["Bad Royale"], map="Basic"):
	
	broadcasting = false
	
	rset("playersAlive", players.keys().size())
	
	for key in players.keys():
		
		matchStats.players[players[key].name] = {"kills":0}
	
	currentMap = map
	
	if get_tree().is_network_server():
		searchPeer = PacketPeerUDP.new()
	
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
	
remotesync func endGame(stats):
	matchStats = stats
	ObjectPool.clearAllPools()
	if Globals.currentGameMode == "Bad Royale":
		get_tree().change_scene("res://Scenes/Screens/MatchStats.tscn")
	elif Globals.currentGameMode == "Team Deathmatch":
		get_tree().change_scene("res://Scenes/Screens/TeamMatchStats.tscn")
	elif Globals.currentGameMode == "Bad Ball":
		get_tree().change_scene("res://Scenes/Screens/BadBallMatchStats.tscn")
	pass
	
	
remotesync func kick():
	
	disconnectedFromHost()
	
	pass
