extends CharacterBody2D

@export var peaceful = false

var player: CharacterBody2D

const BEE_SPEED = 200

func _ready() -> void:
	player = get_tree().get_nodes_in_group("Player")[0]
	
func _process(delta: float) -> void:
	if not peaceful:
		var direction = (player.position - position).normalized()
		print(direction)
		velocity = direction * delta * BEE_SPEED
		print(velocity)
		move_and_slide()
