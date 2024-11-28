extends Sprite2D

@onready var hive_tree: Node2D = $"../.."
@onready var bee_spawner: Node2D = $BeeSpawner
@onready var bee_spawner_2: Node2D = $BeeSpawner2
@onready var bee_spawner_3: Node2D = $BeeSpawner3
@onready var interactable_collision: CollisionShape2D = $Interactable/CollisionShape2D

var bee_scene = preload("res://scenes/bee.tscn")

@onready var bee_spawners = [
	bee_spawner,
	bee_spawner_2,
	bee_spawner_3
]

func _ready() -> void:
	EventController.interaction.connect(_on_interaction)


func _on_interaction(node: Node) -> void:
	if node == self:
		# Ataca o player se as abelhas estiverem acordadas
		if Globals.seasons[Globals.seasons_int] == "Summer" || Globals.seasons[Globals.seasons_int] == "Spring":
			spawn_bees()
		# Pega mel se for outono
		elif Globals.seasons[Globals.seasons_int] == "Autumn":
			texture = load("res://assets/bee_hive.png")
			EventController.save_item_to_inventory.emit("honey")
			interactable_collision.disabled = true


func spawn_bees():
	for id in bee_spawners.size():
		var bee = bee_scene.instantiate() as Node2D
		var bee_spawn_location = bee_spawners[id]
		bee.scale = Vector2(0.333, 0.333)
		bee.position = bee_spawn_location.position
		add_child(bee)
