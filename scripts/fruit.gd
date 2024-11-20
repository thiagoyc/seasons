extends CharacterBody2D

const SPEED = 60

signal fruit_fall()
var activate_animation
signal fruit_on_floor()
var animation_done

@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	activate_animation = false


func _physics_process(delta: float) -> void:
	if activate_animation and not animation_done:
		var collideObject = move_and_collide(Vector2(0, SPEED * delta))
		if collideObject:
			animation_done = true
			emit_signal("fruit_on_floor")


func _on_fruit_fall() -> void:
	activate_animation = true
