extends CharacterBody2D

@onready var interactable_collision: CollisionShape2D = $Interactable/CollisionShape2D

signal free_cat()

func _ready() -> void:
	interactable_collision.disabled = true
	EventController.interaction.connect(_on_interaction)
	free_cat.connect(_on_free_cat)
	
func _on_free_cat() -> void:
	interactable_collision.disabled = false

func _on_interaction(node: Node) -> void:
	if node == self:
		print("YOU WON!")
