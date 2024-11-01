extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 100.0
const JUMP_VELOCITY = -200.0
var casting = false


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta / 2

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() and not casting:
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction and not casting:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if Input.is_action_just_pressed("cast") and is_on_floor():
		casting = true
	
	if is_on_floor():
		if casting:
			animated_sprite_2d.play("begging")
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