# Input map configuration for Cat Climber
# Add this to Project Settings > Input Map

# Player 1 controls
input_map = {
	"jump": [
		{"event": "Key", "keycode": 32},  # Space
		{"event": "JoypadButton", "button_index": 0}
	],
	"pounce": [
		{"event": "Key", "keycode": 16777219},  # Shift
		{"event": "JoypadButton", "button_index": 1}
	]
}
