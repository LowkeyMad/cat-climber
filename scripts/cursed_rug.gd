extends CharacterBody2D

# Cursed Rug parameters
@export var speed: float = 50.0
@export var attack_interval: float = 3.0

# References
@onready var player = $"../Player"
@onready var attack_timer = $AttackTimer

# State
var is_attacking: bool = false
var attack_direction: Vector2

func _ready():
	attack_timer.wait_time = attack_interval
	attack_timer.start()

func _physics_process(delta):
	if is_attacking:
		# Move toward attack position
		var direction = (attack_direction - position).normalized()
		velocity = direction * speed * 2
		move_and_slide()
		
		# Check if reached attack position
		if position.distance_to(attack_direction) < 20:
			is_attacking = false
	else:
		# Hover near player
		var target_pos = player.position + Vector2(-150, -100)
		var direction = (target_pos - position).normalized()
		velocity = direction * speed
		move_and_slide()

func _on_attack_timer_timeout():
	# Choose random attack position
	attack_direction = player.position + Vector2(randf_range(-200, 200), randf_range(-100, 100))
	is_attacking = true

func _on_area_2d_body_entered(body):
	if body.is_in_group("obstacles"):
		# Damage player
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
