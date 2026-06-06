extends Area2D

# Lasagna properties
@export var points: int = 10

func _ready():
	# Add to lasagna group for collision detection
	add_to_group("lasagna")

func _on_body_entered(body):
	if body.is_in_group("player"):
		# Notify spawner of collection
		get_parent()._on_lasagna_collected()
		queue_free()
