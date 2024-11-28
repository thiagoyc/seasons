extends Node2D

@onready var tree: Sprite2D = $Tree
@onready var hive: Sprite2D = $Tree/Hive
@onready var bush: Sprite2D = $Bush
@onready var path_follow_1: PathFollow2D = $Path2D/PathFollow2D
@onready var bee_1: AnimatedSprite2D = $Path2D/PathFollow2D/Bee/AnimatedSprite2D
@onready var path_follow_2: PathFollow2D = $Path2D2/PathFollow2D
@onready var bee_2: AnimatedSprite2D = $Path2D2/PathFollow2D/Bee/AnimatedSprite2D
@onready var path_follow_3: PathFollow2D = $Path2D3/PathFollow2D
@onready var bee_3: AnimatedSprite2D = $Path2D3/PathFollow2D/Bee/AnimatedSprite2D
@onready var interactable_collision: CollisionShape2D = $Tree/Hive/Interactable/CollisionShape2D

var last_id

const BEE_SPEED = 50

const tree_textures = [
	"res://assets/Seasons pack/Summer/Trees/Trees_Summer.png",
	"res://assets/Seasons pack/Autumn/Trees/Trees_Autumn.png",
	"res://assets/Seasons pack/Winter/Trees/Trees_Winter.png",
	"res://assets/Seasons pack/Spring/Trees/Trees_Spring.png"
]

func _ready():
	last_id = -1

func _process(_delta: float) -> void:
	if last_id != Globals.seasons_int:
		last_id = Globals.seasons_int
		tree.texture = load(tree_textures[Globals.seasons_int])
		
		if Globals.seasons[Globals.seasons_int] == "Winter":
			hive.texture = load("res://assets/bee_hive.png")
		else:
			interactable_collision.disabled = false
			hive.texture = load("res://assets/bee_hive_full.png")
		
		# Abelhas e flores
		if Globals.seasons[Globals.seasons_int] == "Summer" || Globals.seasons[Globals.seasons_int] == "Spring":
			bush.texture = load("res://assets/bush_flowers.png")
			bee_1.visible = true
			bee_2.visible = true
			bee_3.visible = true
		else:
			bush.texture = load("res://assets/bush.png")
			bee_1.visible = false
			bee_2.visible = false
			bee_3.visible = false
	
	path_follow_1.progress += _delta * BEE_SPEED
	path_follow_2.progress += _delta * BEE_SPEED
	path_follow_3.progress += _delta * BEE_SPEED
	if path_follow_1.progress_ratio >= 0.5:
		bee_1.flip_h = true
	else:
		bee_1.flip_h = false
	if path_follow_2.progress_ratio >= 0.5:
		bee_2.flip_h = true
	else:
		bee_2.flip_h = false
	if path_follow_3.progress_ratio >= 0.5:
		bee_3.flip_h = true
	else:
		bee_3.flip_h = false
