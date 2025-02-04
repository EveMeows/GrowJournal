extends Node2D

@export var seed_container: VBoxContainer
@export var settings_view: Control

@export var wl_history:  Label
@export var dl_history:  Label
@export var gem_history: Label

@export var wl_count:  LineEdit
@export var dl_count:  LineEdit
@export var gem_count: LineEdit

var seed_scene: PackedScene = preload("res://Scenes/seed.tscn")


func _ready() -> void:
	# Load webhook data
	# In case the user clicks send without opening settings
	Global.load_url()
	
	if not Global.load_data(): return
	set_data()


func set_seed(block_name: String, texture: String):
	var s := seed_scene.instantiate()
	s.set_data(block_name, load(texture))
	
	seed_container.add_child(s)


func set_data() -> void:
	wl_history.text = "History: " + Global.data["wl"]
	dl_history.text = "History: " + Global.data["dl"]
	gem_history.text = "History: " + Global.data["gems"]


func format_data(line: LineEdit) -> String:
	var text: String = line.text.strip_edges(true, true)
	return text if text != "" else "0"


func on_settings_pressed() -> void:
	# Load webhook data
	Global.load_url()
	settings_view.line.text = Global.webhook_data["url"]
	
	settings_view.visible = true


func on_done_pressed() -> void:
	Global.save_data(
		format_data(wl_count), format_data(dl_count),
		format_data(gem_count)
	)
	
	set_data()
	Webhook.send_payload()


# I have no better way to do this :sob:
func on_pepper_pressed() -> void:
	set_seed("pepper", "res://Content/Images/Blocks/Pepper.png")

func on_chand_pressed() -> void:
	set_seed("chand", "res://Content/Images/Blocks/Chandelier.png")

func on_laser_pressed() -> void:
	set_seed("Laser Grid", "res://Content/Images/Blocks/Laser.png")

func on_ftank_pressed() -> void:
	set_seed("Fish Tank", "res://Content/Images/Blocks/FishTank.png")

func on_sugarcane_pressed() -> void:
	set_seed("Sugar Cane", "res://Content/Images/Blocks/SugarCane.png")
