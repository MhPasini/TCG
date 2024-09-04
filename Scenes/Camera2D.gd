extends Camera2D

var rng = RandomNumberGenerator.new()

var current_shake_strength: float = 0.0
var shake_fade_speed: float = 0.0

func _ready():
	# Turn off processing when not shaking
	set_process(false)
	

func shake(initial_shake_strength: float = 25.0, shake_duration: float = 0.25):
	# initial_shake_strength = Initial strength of the camera shake
	# shake_duration = Duration of the shake effect in seconds
	
	# Calculate the fade speed based on the duration and initial strength
	shake_fade_speed = initial_shake_strength / shake_duration
	
	# When shake is initiated, turn on the process
	set_process(true)
	
	# Set the current shake strength to the initial strength
	current_shake_strength = initial_shake_strength
	
func generate_random_offset() -> Vector2:
	# Generate a random offset vector based on the current shake strength
	return Vector2(rng.randf_range(-current_shake_strength, current_shake_strength), rng.randf_range(-current_shake_strength, current_shake_strength))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_shake_strength > 0:
		current_shake_strength = move_toward(current_shake_strength, 0, shake_fade_speed * delta)
		offset = generate_random_offset()
	else:
		# Turn off processing when the shake ends
		set_process(false)
