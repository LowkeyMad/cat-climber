extends CanvasLayer

# UI elements
@onready var score_label = $ScoreLabel
@onready var player = $"../Player"

func _process(delta):
	# Update score display
	if player:
		score_label.text = "Lasagna: %d" % player.score
