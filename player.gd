extends CharacterBody2D

# Player movement parameters
@export var base_speed: float = 100.0
@export var acceleration: float = 10.0
@export var jump_force: float = -300.0
@export var gravity: float = 900.0
@export var pounce_force: float = -400.0

# Cat behavior
@onready var cat_sprite = $CatSprite
@onready var hero_sprite = $HeroSprite

# Network sync
@export var is_networked: bool = true

# State
var score: int = 0

func _ready():
	# Initialize cat's lazy behavior
	cat_sprite.modulate = Color(1, 0.6, 0.2)  # Orange color
	hero_sprite.modulate = Color(1, 1, 1)   # White mustache
	add_to_group("player")

func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Handle movement input
	var direction = Input.get_axis("left", "right")
	velocity.x = direction * base_speed
	
	# Handle acceleration (optional: uncomment if you want acceleration)
	# velocity.x += acceleration * direction * delta
	
	# Handle jumping
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force
	
	# Handle pounce (special move)
	if Input.is_action_just_pressed("pounce") and is_on_floor():
		velocity.y = pounce_force
	
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
		score += body.points
		body.queue_free()
	elif body.is_in_group("obstacles"):
		# Game over logic
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
