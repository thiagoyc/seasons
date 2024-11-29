extends Node2D

@onready var fire_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var killzone: CollisionShape2D = $Killzone/CollisionShape2D

var burn_duration: float = 1.0
var burn = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventController.interaction.connect(_on_interaction)
	killzone.disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if burn:
		start_burning()


func start_burning():
	fire_sprite.visible = true
	fire_sprite.play()
	killzone.disabled = false
	
	await get_tree().create_timer(burn_duration).timeout
	queue_free()


func _on_interaction(node: Node) -> void:
	if node == self:
		burn = true
