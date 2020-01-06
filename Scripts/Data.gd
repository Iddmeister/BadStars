extends Node

var dataLocation = "user://saveData.save"

var data = {
	
	"playerName":"EpicDude53",
	
	}

func _ready():
	startup()
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
	
func saveData():
	
	var file = File.new()
	
	file.open(dataLocation, File.WRITE)
	
	file.store_line(to_json(data))
	
	file.close()
	
	pass
	
