extends PanelContainer

@export var block_label: Label
@export var block_rect: TextureRect


func set_data(name: String, texture: Texture2D):
	block_label.text = name
	block_rect.texture = texture


func on_erase_pressed() -> void:
	queue_free()
