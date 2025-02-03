extends Control


func on_close_pressed() -> void:
	visible = false


func on_close_app_pressed() -> void:
	get_tree().quit()
