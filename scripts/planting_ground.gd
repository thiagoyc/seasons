extends Node2D

@onready var tree: Node2D = $Tree
@onready var interactable_collision: CollisionShape2D = $Interactable/CollisionShape2D
@onready var water_area: StaticBody2D = $WaterArea
@onready var water_area_collision: CollisionShape2D = $WaterArea/CollisionShape2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tree.emit_signal("ungrow_tree")
	interactable_collision.disabled = false
	water_area_collision.disabled = false
	EventController.interaction.connect(_on_interaction)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_interaction(node: Node) -> void:
	if node == water_area:
		tree.emit_signal("water_tree")
		tree.emit_signal("make_climbable")
		water_area_collision.disabled = true
	
	if node == self:
		if Globals.inventory_item == "seed":
			tree.emit_signal("plant_tree")
			tree.emit_signal("make_climbable")
			interactable_collision.disabled = true
			EventController.use_item_of_inventory.emit()
