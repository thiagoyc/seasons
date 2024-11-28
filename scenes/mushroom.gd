extends Node2D

@onready var mushroom_brown: Sprite2D = $MushroomBrown
@onready var interactable_collision: CollisionShape2D = $Interactable/CollisionShape2D

func _ready() -> void:
	EventController.interaction.connect(_on_interaction)

func _on_interaction(node: Node) -> void:
	if node == self:
		mushroom_brown.visible = false
		interactable_collision.disabled = true
		EventController.save_item_to_inventory.emit("mushroom")
