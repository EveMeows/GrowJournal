extends Node2D

@export var seed_container: VBoxContainer
@export var settings_view: Control

@export var wl_history:  Label
@export var dl_history:  Label
@export var gem_history: Label

@export var wl_count:  LineEdit
@export var dl_count:  LineEdit
@export var gem_count: LineEdit

@export var seed_holder: VBoxContainer

var seed_scene: PackedScene = preload("res://Scenes/seed.tscn")


func _ready() -> void:
	# Load webhook data
	# In case the user clicks send without opening settings
	Global.load_url()
	
	if not Global.load_data(): return
	set_data(true)
	
	for seed_data in Global.data["seeds"]:
		set_seed_history(seed_data["name"], seed_data["history"])


func set_seed(block_name: String):
	var s := seed_scene.instantiate()
	s.set_data(block_name, load(Global.seed_map[block_name]))
	
	seed_container.add_child(s)


func set_seed_history(block_name: String, history: String):
	var s := seed_scene.instantiate()
	s.set_data(block_name, load(Global.seed_map[block_name]))
	
	s.history_label.text = "(%s)" % history
	s.seed_data.text = history
	
	seed_container.add_child(s)


func set_data(edit_text: bool = false) -> void:
	wl_history.text  = "History: " + Global.data["wl"]
	dl_history.text  = "History: " + Global.data["dl"]
	gem_history.text = "History: " + Global.data["gems"]
	
	if not edit_text: return
	wl_count.text  = Global.data["wl"]
	dl_count.text  = Global.data["dl"]
	gem_count.text = Global.data["gems"]


func format_data(line: LineEdit) -> String:
	var text: String = line.text.strip_edges(true, true)
	return text if text != "" else "0"


func handle_seeds() -> void:
	Global.data["seeds"].clear()

	var children: Array[Node] = seed_holder.get_children()
	for child in children:
		var history: String = format_data(child.seed_data)
		child.history_label.text = "(%s)" % history
		
		var seed_data: Dictionary = {
			name = child.block_label.text,
			history = history
		}

		Global.data["seeds"].push_back(seed_data)


func on_settings_pressed() -> void:
	# Load webhook data
	Global.load_url()
	settings_view.line.text = Global.webhook_data["url"]
	
	settings_view.visible = true


func on_done_pressed() -> void:
	handle_seeds()
	Global.save_data(
		format_data(wl_count), format_data(dl_count),
		format_data(gem_count)
	)
	
	set_data()
	Webhook.send_payload()


# I have no better way to do this :sob:
func on_pepper_pressed() -> void:
	set_seed("Pepper")

func on_chand_pressed() -> void:
	set_seed("Chand")

func on_laser_pressed() -> void:
	set_seed("Laser Grid")

func on_ftank_pressed() -> void:
	set_seed("Fish Tank")

func on_sugarcane_pressed() -> void:
	set_seed("Sugar Cane")
