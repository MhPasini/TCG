extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	self.hide()  # Hide the death screen initially

# Function to trigger the game over screen with animations
func game_over():
	# Show the CanvasLayer to start animations
	self.show()
	_game_over_anims()


func _game_over_anims():
	# Modulate label opacity
	$Label.modulate.a = 0  # Start with 0 opacity
	$Label.scale = Vector2(0.5, 0.5)  # Start scaled down
	$Panel.modulate.a = 0  # Start with 0 opacity
	
	# Maka animation start from center
	$Label.set_pivot_offset($Label.size / 2)
	# Create a tween for animations
	var tween = create_tween().set_parallel().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)

	# Animation for the Label: fade in and scale up
	tween.tween_property($Label, "modulate:a", 1, 0.5)  # Fade to full opacity over 1 second
	tween.tween_property($Label, "scale", Vector2(1, 1), 1)  # Scale to full size over 1 second

	# Animation for the background: fade in
	tween.tween_property($Panel, "modulate:a", 0.5, 1.0)  # Fade to 0.5 opacity over 1 second

	# Set easing and transition for smoother animations
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)


