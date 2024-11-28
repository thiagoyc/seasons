extends CharacterBody2D

@export var peaceful = false
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var killzone: CollisionShape2D = $Killzone/CollisionShape2D

var player: CharacterBody2D

const BEE_SPEED = 75

func _ready() -> void:
	player = get_tree().get_nodes_in_group("Player")[0]
	killzone.disabled = true
	
func _process(delta: float) -> void:
	if not peaceful:
		collision_shape.disabled = true
		killzone.disabled = false
		var direction = (player.global_position - global_position).normalized()
		look_at(player.global_position)
		velocity = direction * delta * BEE_SPEED
		var colliderObject = move_and_collide(velocity)
