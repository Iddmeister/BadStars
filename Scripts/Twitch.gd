extends Gift

var channel:String

enum {NOTHING, MAP, MODE}

var votingFor = NOTHING

var votes = {}

var voted = []

func _ready() -> void:
	connect("cmd_no_permission", self, "no_permission")
	connect("cmd_invalid_argcount", self, "invalid_args")


	
func setup(chan:String):
	channel = chan
	connect_to_twitch()
	yield(self, "twitch_connected")
	
	authenticate_oauth("41ywhe0x72lu8elxs5t99e24d7wdkh", "oauth:hac0l6r8t8h6dhse1tbmct0u956qhu")
	if(yield(self, "login_attempt") == false):
	  Popups.failed()
	  return
	join_channel(channel)
	chat("Connected")
	
	add_command("howzit", self, "checkup")
	add_command("vote", self, "vote", 2, 2)
	add_command("help", self, "help")
	
	pass
	

func vote(cmd_info:CommandInfo, args:PoolStringArray):
	
	if not cmd_info.sender_data.user in voted:
		
		if votingFor == MAP:
		
			if args[0] == "map":
				if Globals.maps[Globals.currentGameMode].has(args[1]):
					voted.append(cmd_info.sender_data.user)
					chat("Voted")
					if not votes.has(args[1]):
						votes[args[1]] = 1
					else:
						votes[args[1]]+=1
				else:
					chat("The current Gamemode does not contain this map")
				pass
			
		elif votingFor == NOTHING:
			chat("Voting is not currently open")
	else:
		chat(String(cmd_info.sender_data.user)+" you have already voted")
	
	pass
	
func help(cmd_info:CommandInfo):
	
	chat("Type '!vote map <map>' to vote for a map")
	
	pass
	
func resetVotes():
	
	votes = {}
	voted.clear()
	
	pass
	
	
func checkup(cmd_info:CommandInfo):
	chat("I'm doing good, thanks for asking, " + String(cmd_info.sender_data.user))
	pass
	
func no_permission(cmd_info : CommandInfo) -> void:
	chat(String(cmd_info.sender_data.user) + " you do not have permisson to use this command!")
	
func invalid_args(cmd_name, sender_data, cmd_data, arg_ary) -> void:
	chat("Invalid arguments for " + String(cmd_name))
