extends CharacterBody2D

@onready var area_collision: CollisionShape2D = $Area2D/CollisionShape2D
@onready var speech_bubble: Sprite2D = $SpeechBubble
@onready var bear: CharacterBody2D = $"."
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var carrying_small_cat: CharacterBody2D = $AnimatedSprite2D/SmallCat
@onready var cat_sprite: AnimatedSprite2D = $AnimatedSprite2D/SmallCat/AnimatedSprite2D
@onready var interactable_collision: CollisionShape2D = $Interactable/CollisionShape2D

var cave
var small_cat: CharacterBody2D
var initial_x
var honey_received

const BEAR_SPEED = 50

func _ready() -> void:
	EventController.interaction.connect(_on_interaction)
	speech_bubble.visible = false
	bear.collision_layer = 0b0011
	initial_x = transform.get_origin().x
	cave = get_tree().get_nodes_in_group("Cave")[0]
	small_cat = get_tree().get_nodes_in_group("SmallCat")[0]
	animated_sprite.flip_h = false
	carrying_small_cat.visible = false
	honey_received = false

func _process(delta: float) -> void:
	if honey_received:
		if(position.x < cave.position.x):
			var direction = 1
			animated_sprite.flip_h = true
			speech_bubble.visible = false
			animated_sprite.play("running")
			interactable_collision.disabled = true
			small_cat.emit_signal("free_cat")
			move_local_x(BEAR_SPEED * delta * direction)
		else:
			animated_sprite.play("idle")
			bear.collision_layer = 0b0010
			speech_bubble.visible = false
			fade_out(1.0)
	else:
		if Globals.seasons[Globals.seasons_int] == "Autumn":
			if(position.x < cave.position.x):
				var direction = 1
				animated_sprite.flip_h = true
				carrying_small_cat.visible = true
				cat_sprite.flip_h = true
				speech_bubble.visible = false
				animated_sprite.play("running")
				small_cat.visible = false
				interactable_collision.disabled = true
				move_local_x(BEAR_SPEED * delta * direction)
			else:
				animated_sprite.play("idle")
				bear.collision_layer = 0b0010
				speech_bubble.visible = false
				fade_out(1.0)
		elif Globals.seasons[Globals.seasons_int] == "Spring":
			if(position.x > initial_x):
				fade_in(1.0)
				var direction = -1
				animated_sprite.flip_h = false
				carrying_small_cat.visible = true
				cat_sprite.flip_h = false
				animated_sprite.play("running")
				small_cat.visible = false
				speech_bubble.visible = false
				move_local_x(BEAR_SPEED * delta * direction)
			else:
				animated_sprite.play("idle")
				bear.collision_layer = 0b0011
				small_cat.visible = true
				carrying_small_cat.visible = false
				interactable_collision.disabled = false

func fade_out(duration: float) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 0, duration)  # Deixa o alpha em 0 (transparente)

func fade_in(duration: float) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 1, duration)  # Deixa o alpha em 1 (totalmente visível)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		speech_bubble.visible = true
		area_collision.disabled = true

func _on_interaction(node: Node) -> void:
	if node == self:
		if Globals.inventory_item == "honey":
			honey_received = true
			EventController.use_item_of_inventory.emit()
