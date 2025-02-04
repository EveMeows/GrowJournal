extends Node

var data: Dictionary = {
	"wl": "0",
	"dl": "0",
	"gems": "0",
}

var webhook_data: Dictionary = {
	"url": ""
}

func save_data(wl: String, dl: String, gems: String) -> void:
	data["wl"] = wl; data["dl"] = dl
	data["gems"] = gems
	
	var save: FileAccess = FileAccess.open("user://data.save", FileAccess.WRITE)
	var json: String = JSON.stringify(data)
	
	save.store_string(json)


func save_url(webhook: String) -> void:
	webhook_data["url"] = webhook
	
	var save: FileAccess = FileAccess.open("user://webhook.save", FileAccess.WRITE)
	var json: String = JSON.stringify(webhook_data)
	
	save.store_string(json)


func load_url() -> void:
	if not FileAccess.file_exists("user://webhook.save"):
		return
	
	var file_data: FileAccess = FileAccess.open("user://webhook.save", FileAccess.READ)
	var url_data: Variant = JSON.parse_string(file_data.get_as_text().strip_edges(true, true))
	webhook_data["url"] = url_data["url"]
	
	file_data.close()
