extends CharacterBody2D

@onready var fire_sprite: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 1000.0

signal leaves_fall()
var initial_position
var drop = false

var pushable = false
var push = false
var direction = 0

var can_delete = false
var burn_duration: float = 1.0
var burn = false


func _ready():
	initial_position = global_position
	print("Initial position saved: ", initial_position)


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() and drop:
		velocity += get_gravity() * delta
	
	if push:
		velocity.x = direction * delta * SPEED
	else:
		velocity.x = 0
	
	if Globals.seasons[Globals.seasons_int] == "Summer" and drop:
		start_burning()
	elif Globals.seasons[Globals.seasons_int] == "Autumn" and drop:
		if can_delete:
			stop_burning()
			global_position = initial_position

	move_and_slide()


func _on_leaves_fall() -> void:
	drop = true
	pushable = true


func _on_right_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and pushable:
		direction = -1
		push = true
	
	if body.get_parent().is_in_group("Flamable"):
		if burn: set_on_fire(body.get_parent())


func _on_left_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and pushable:
		direction = 1
		push = true
	
	if body.get_parent().is_in_group("Flamable"):
		if burn: set_on_fire(body.get_parent())


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player") and pushable:
		direction = 0
		push = false


func start_burning():
	burn = true
	can_delete = true
	fire_sprite.visible = true
	fire_sprite.play()


func stop_burning():
	burn = false
	can_delete = false
	fire_sprite.visible = false
	fire_sprite.stop()


func set_on_fire(object: Node2D):
	EventController.interaction.emit(object)
	pushable = false
	direction = 0
	push = false
	
	await get_tree().create_timer(burn_duration).timeout
	drop = false
	stop_burning()
	global_position = initial_position
