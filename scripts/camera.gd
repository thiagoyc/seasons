extends Camera2D

@export var randomStrength: float = 0.5
@export var shakeFade: float = 1.0
@export var stabilizationSpeed: float = 4

var rng = RandomNumberGenerator.new()
var shake_strength: float = 0.0
var target_strength: float = 0.0

var is_shaking: bool = false

func _ready():
	EventController.shake_camera.connect(_shake_camera)
	EventController.stabilize_camera.connect(_stabilize_camera)

func _shake_camera():
	is_shaking = true
	target_strength = randomStrength

func _stabilize_camera():
	is_shaking = false
	target_strength = 0.0

func _process(delta):
	shake_strength = lerp(shake_strength, target_strength, stabilizationSpeed * delta)
	if shake_strength > 0.01:
		offset = randomOffset()
	else:
		offset = Vector2.ZERO

func randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength, shake_strength), rng.randf_range(-shake_strength, shake_strength))
