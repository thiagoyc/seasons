extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var fruit: CharacterBody2D = $"../Fruit"
@onready var holding_fruit: Sprite2D = $HoldingFruit
@onready var interactable_collision: CollisionShape2D = $Interactable/CollisionShape2D
@onready var speech_bubble: Sprite2D = $SpeechBubble
@onready var holding_mushroom: Sprite2D = $HoldingMushroom

const speed = 60
var direction = 1

var seed_given = false
var activate_animation = false
var go_to_fruit = true
var go_back = false
var initial_x

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	activate_animation = false
	go_to_fruit = true
	go_back = false
	seed_given = false
	initial_x = transform.get_origin().x
	interactable_collision.disabled = true
	EventController.interaction.connect(_on_interaction)
	speech_bubble.visible = false
	holding_mushroom.visible = false
	holding_fruit.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if seed_given:
		animated_sprite.play("holding")
	else:
		if activate_animation:
			if go_to_fruit:
				direction = -1
				animated_sprite.play("running")
				var collideObject = move_and_collide(Vector2(speed * delta * direction, 0))
				if collideObject:
					fruit.visible = false
					go_to_fruit = false
					go_back = true
			elif go_back:
				direction = 1
				animated_sprite.flip_h = false
				animated_sprite.play("running")
				move_local_x(speed * delta * direction)
				if transform.get_origin().x >= initial_x:
					go_back = false
			else:
				animated_sprite.play("holding")
				animated_sprite.flip_h = true
				holding_fruit.visible = true
				interactable_collision.disabled = false
				activate_animation = false
		if Globals.seasons[Globals.seasons_int] != "Summer":
			activate_animation = false
			interactable_collision.disabled = true
			holding_fruit.visible = false
			go_to_fruit = true
			go_back = true
			animated_sprite.play("idle")
			speech_bubble.visible = false
		
func _on_fruit_fruit_on_floor() -> void:
	activate_animation = true

func _on_interaction(node: Node) -> void:
	if node == self:
		if not speech_bubble.visible:
			speech_bubble.visible = true
		elif Globals.inventory_item == "mushroom":
			speech_bubble.visible = false
			interactable_collision.disabled = true
			holding_fruit.visible = false
			holding_mushroom.visible = true
			seed_given = true
			EventController.save_item_to_inventory.emit("seed")
			
