extends CharacterBody2D

@onready var fire_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var killzone: CollisionShape2D = $Killzone/CollisionShape2D

const SPEED = 1500.0

signal leaves_fall()
var initial_position
var drop = false

var pushable = false
var push = false
var direction = 0

var can_delete = false
var burn_duration: float = 1.0
var burn = false

var on_flamable_ground = false
var flamable_body


func _ready():
	initial_position = global_position
	collision.disabled = true
	killzone.disabled = true


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() and drop:
		velocity += get_gravity() * delta
	
	if is_on_floor(): drop = false
	
	if pushable: collision.disabled = false
	else: collision.disabled = true
	
	if push:
		velocity.x = direction * delta * SPEED
	else:
		velocity.x = 0
	
	if Globals.seasons[Globals.seasons_int] == "Summer" and is_on_floor():
		start_burning()
	elif Globals.seasons[Globals.seasons_int] == "Autumn" and is_on_floor():
		if can_delete:
			stop_burning()
			global_position = initial_position
	
	if on_flamable_ground and burn:
		set_on_fire(flamable_body)

	move_and_slide()


func _on_leaves_fall() -> void:
	drop = true
	pushable = true


func _on_right_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and pushable:
		direction = -1
		push = true
	
	if body.get_parent().is_in_group("Flamable"):
		flamable_body = body.get_parent()
		on_flamable_ground = true


func _on_left_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and pushable:
		direction = 1
		push = true
	
	if body.get_parent().is_in_group("Flamable"):
		flamable_body = body.get_parent()
		on_flamable_ground = true


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player") and pushable:
		direction = 0
		push = false
	
	if body.get_parent().is_in_group("Flamable"):
		on_flamable_ground = false


func start_burning():
	burn = true
	can_delete = true
	fire_sprite.visible = true
	fire_sprite.play()
	killzone.disabled = false


func stop_burning():
	burn = false
	can_delete = false
	fire_sprite.visible = false
	fire_sprite.stop()
	killzone.disabled = true


func set_on_fire(object: Node2D):
	EventController.interaction.emit(object)
	pushable = false
	direction = 0
	push = false
	
	await get_tree().create_timer(burn_duration).timeout
	drop = false
	stop_burning()
	global_position = initial_position
