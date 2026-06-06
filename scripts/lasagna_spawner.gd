extends Node2D

# Lasagna spawning parameters
@export var spawn_rate: float = 2.0
@export var min_spawn_rate: float = 0.5
@export var spawn_height: float = 100.0

# References
@onready var player = $"../Player"
@onready var lasagna_scene = preload("res://scenes/lasagna.tscn")

# Spawning state
var spawn_timer: float = 0.0
var current_spawn_rate: float

func _ready():
	current_spawn_rate = spawn_rate
	randomize()

func _process(delta):
	spawn_timer += delta
	
	# Increase difficulty over time
	current_spawn_rate = max(min_spawn_rate, spawn_rate - (get_tree().get_elapsed_time() / 60.0))
	
	if spawn_timer >= current_spawn_rate:
		spawn_lasagna()
		spawn_timer = 0.0

func spawn_lasagna():
	var lasagna = lasagna_scene.instantiate()
	
	# Random position off-screen to the right
	var spawn_x = player.position.x + 1000 + randf_range(0, 500)
	var spawn_y = randf_range(50, 400)
	
	lasagna.position = Vector2(spawn_x, spawn_y)
	add_child(lasagna)

func _on_lasagna_collected():
	# Could add score tracking here
	pass
