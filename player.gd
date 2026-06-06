extends CharacterBody2D

# Player movement parameters
@export var base_speed: float = 150.0
@export var acceleration: float = 20.0
@export var jump_force: float = -350.0
@export var gravity: float = 1200.0
@export var pounce_force: float = -450.0

# Cat behavior
@onready var cat_sprite = $CatSprite
@onready var hero_sprite = $HeroSprite

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
	velocity.x = move_toward(velocity.x, direction * base_speed, acceleration * delta)
	
	# Handle jumping
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force
	
	# Handle pounce (special move)
	if Input.is_action_just_pressed("pounce") and is_on_floor():
		velocity.y = pounce_force
	
	move_and_slide()
	
	# Check for collisions after moving
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		if collider and collider.is_in_group("lasagna"):
			# Collect lasagna
			score += collider.points
			collider.queue_free()
		elif collider and collider.is_in_group("obstacles"):
			# Game over logic
			get_tree().change_scene_to_file("res://scenes/game_over.tscn")
