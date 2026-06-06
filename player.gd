extends CharacterBody2D

# Player movement parameters
@export var base_speed: float = 100.0
@export var acceleration: float = 10.0
@export var jump_force: float = -300.0
@export var gravity: float = 900.0

# Cat behavior
@onready var cat_sprite = $CatSprite
@onready var hero_sprite = $HeroSprite

# Network sync
@export var is_networked: bool = true

func _ready():
	# Initialize cat's lazy behavior
	cat_sprite.modulate = Color(1, 0.6, 0.2)  # Orange color
	hero_sprite.modulate = Color(1, 1, 1)   # White mustache

func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Handle automatic forward acceleration
	velocity.x = base_speed + (acceleration * get_tree().get_elapsed_time())
	
	# Handle jumping
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force
	
	# Handle co-op input (second player)
	if is_networked:
		_handle_coop_input()
	
	move_and_slide()

func _handle_coop_input():
	# Placeholder for co-op controls
	# This would be expanded with actual network input handling
	pass

func _on_area_2d_body_entered(body):
	# Collision with lasagna items or obstacles
	if body.is_in_group("lasagna"):
		# Collect lasagna
		body.queue_free()
	elif body.is_in_group("obstacles"):
		# Game over logic
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
