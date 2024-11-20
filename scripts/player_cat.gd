extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@onready var jumping_sound_fx: AudioStreamPlayer = $Jumping
@onready var walking_leaves_fx: AudioStreamPlayer = $"walking-leaves"
@onready var cracking_earthquake: AudioStreamPlayer = $"Cracking-earthquake"

const SPEED = 60.0
const JUMP_VELOCITY = -100.0

var is_dead
var casting
signal cast_done()

func _ready():
	is_dead = false
	casting = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta / 3

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() and not casting:
		velocity.y = JUMP_VELOCITY
		jumping_sound_fx.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction and not casting:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if Input.is_action_just_pressed("cast") and is_on_floor():
		casting = true
		cracking_earthquake.play()
	
	if is_on_floor() and velocity.x != 0:
		if walking_leaves_fx.is_playing() == false:
			walking_leaves_fx.play()
	else:
		if walking_leaves_fx.is_playing():
			walking_leaves_fx.stop()



	# Flip horizontally
	if not casting:
		if direction > 0:
			animated_sprite_2d.flip_h = true
		elif direction < 0:
			animated_sprite_2d.flip_h = false
	
	# Animations
	if is_on_floor():
		if casting:
			animated_sprite_2d.play("begging")
			EventController.emit_signal("shake_camera")
		elif direction == 0:
			animated_sprite_2d.play("sitting")
		else:
			animated_sprite_2d.play("running")
	else:
		animated_sprite_2d.play("jumping")
	
	move_and_slide()


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "begging":
		casting = false
		emit_signal("cast_done")
		EventController.emit_signal("stabilize_camera")
