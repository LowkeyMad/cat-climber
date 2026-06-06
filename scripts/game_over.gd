extends Control

func _ready():
	# Ensure the restart button is connected
	$Button.pressed.connect(self._on_restart_pressed)

func _on_restart_pressed():
	get_tree().change_scene_to_file("res://main.tscn")
