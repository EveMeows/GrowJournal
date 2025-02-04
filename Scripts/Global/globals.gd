extends Node

var data: Dictionary = {
	"wl": "0",
	"dl": "0",
	"gems": "0",
	
	"seeds": []
}

var webhook_data: Dictionary = {
	"url": ""
}

var seed_map: Dictionary = {
	"Pepper": "res://Content/Images/Blocks/Pepper.png",
	"Chand": "res://Content/Images/Blocks/Chandelier.png",
	"Laser Grid": "res://Content/Images/Blocks/Laser.png",
	"Fish Tank": "res://Content/Images/Blocks/FishTank.png",
	"Sugar Cane": "res://Content/Images/Blocks/SugarCane.png"
}

func save_data(wl: String, dl: String, gems: String) -> void:
	data["wl"] = wl; data["dl"] = dl
	data["gems"] = gems
	
	var save: FileAccess = FileAccess.open("user://data.save", FileAccess.WRITE)
	var json: String = JSON.stringify(data)
	
	save.store_string(json)


func load_data() -> bool:
	if not FileAccess.file_exists("user://data.save"):
		return false
	
	var file_data: FileAccess = FileAccess.open("user://data.save", FileAccess.READ)
	var gt_data: Variant = JSON.parse_string(file_data.get_as_text().strip_edges(true, true))
	
	data["wl"]    = gt_data["wl"]
	data["dl"]    = gt_data["dl"]
	data["gems"]  = gt_data["gems"]
	data["seeds"] = gt_data["seeds"]

	file_data.close()
	
	return true


func save_url(webhook: String) -> void:
	webhook_data["url"] = webhook
	
	var save: FileAccess = FileAccess.open("user://webhook.save", FileAccess.WRITE)
	var json: String = JSON.stringify(webhook_data)
	
	save.store_string(json)


func load_url() -> bool:
	if not FileAccess.file_exists("user://webhook.save"):
		return false
	
	var file_data: FileAccess = FileAccess.open("user://webhook.save", FileAccess.READ)
	var url_data: Variant = JSON.parse_string(file_data.get_as_text().strip_edges(true, true))
	webhook_data["url"] = url_data["url"]
	
	file_data.close()
	return true
