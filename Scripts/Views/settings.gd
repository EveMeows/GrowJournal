extends Control

@export var line: LineEdit


func on_close_pressed() -> void:
	visible = false


func on_close_app_pressed() -> void:
	get_tree().quit()


func on_save_pressed() -> void:
	var url: String = line.text.strip_edges(true, true)
	Global.save_url(url)


func on_history_clear_pressed() -> void:
	if not FileAccess.file_exists("user://data.save"): return
	DirAccess.remove_absolute("user://data.save")
