extends Node

var dataLocation = "user://saveData.save"

var data = {
	
	"playerName":"EpicDude53",
	"lastPlayed":2,
	
	}

func _ready():
	startup()
	checkData()
	pass
	
func startup():
	
	var file = File.new()
	
	if file.file_exists(dataLocation):
		retrieveData()
	else:
		saveData()
		
	file.close()
	
func retrieveData():
	
	var file = File.new()
	
	file.open(dataLocation, File.READ)
	
	data = parse_json(file.get_line())
	
	file.close()
	
	pass
	
func checkData():
	
	if not data.has("lastPlayed"):
		data["lastPlayed"] = 0
		saveData()
	
	pass
	
func saveData():
	
	var file = File.new()
	
	file.open(dataLocation, File.WRITE)
	
	file.store_line(to_json(data))
	
	file.close()
	
	pass
	
