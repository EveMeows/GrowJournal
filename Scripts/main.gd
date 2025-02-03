extends Node2D

@export var seed_container: VBoxContainer

var seed_scene = preload("res://Scenes/seed.tscn")

func set_seed(name: String, texture: String):
	var seed = seed_scene.instantiate()
	seed.set_data(name, load(texture))
	
	seed_container.add_child(seed)


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
