extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
#var leaves: Node = null

const SPEED = 60.0
const JUMP_VELOCITY = -100.0

const PUSH_FORCE = 15.0

var casting = false
signal cast_done()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta / 3

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
		elif direction == 0:
			animated_sprite_2d.play("sitting")
		else:
			animated_sprite_2d.play("running")
	else:
		animated_sprite_2d.play("jumping")
	
	move_and_slide()
	
	#for i in get_slide_collision_count():
		#var coll = get_slide_collision(i)
		#if coll.get_collider() is RigidBody2D:
			#coll.get_collider().apply_central_force(-coll.get_normal() * PUSH_FORCE)
	#
	#if Input.is_action_just_pressed("pull") and leaves:
		#leaves.connect_to_player(self)
	#elif Input.is_action_just_released("pull") and leaves:
		#leaves.disconnect_from_player()


#func interact_with_leaves(leaves_node: Node):
	#leaves = leaves_node  # Store the reference to the leaves


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "begging":
		casting = false
		emit_signal("cast_done")
