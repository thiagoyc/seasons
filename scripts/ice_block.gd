extends CharacterBody2D


@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D

const SPEED = 500.0

var pushable = false
var push = false
var direction = 0

var frozen = false


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() and frozen:
		velocity += get_gravity() * delta
	
	if push:
		velocity.x = direction * delta * SPEED
	else:
		velocity.x = 0
	
	if frozen:
		collision.disabled = false
	else:
		collision.disabled = true
		velocity = Vector2(0,0)
	
	if Globals.seasons[Globals.seasons_int] == "Winter" and !frozen:
		freeze()
	elif Globals.seasons[Globals.seasons_int] != "Winter" and frozen:
		unfreeze()
	
	move_and_slide()


func _on_right_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and pushable:
		direction = -1
		push = true


func _on_left_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and pushable:
		direction = 1
		push = true


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player") and pushable:
		direction = 0
		push = false


func freeze():
	frozen = true
	animation.play("Freeze")
	pushable = true


func unfreeze():
	frozen = false
	pushable = false
	animation.play("Unfreeze")
