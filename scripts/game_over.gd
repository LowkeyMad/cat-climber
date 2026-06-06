extends Control

@onready var restart_button = $Button

func _ready():
	restart_button.connect("pressed", _on_restart_pressed)

func _on_restart_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
