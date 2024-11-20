extends Node2D

@onready var tree: Sprite2D = $Tree
@onready var fruit: CharacterBody2D = $Fruit
@onready var area_2d: Area2D = $Area2D

var texture_id
var last_id

const textures = [
	"res://assets/Seasons pack/Summer/Trees/Trees_Summer.png",
	"res://assets/Seasons pack/Autumn/Trees/Trees_Autumn.png",
	"res://assets/Seasons pack/Winter/Trees/Trees_Winter.png",
	"res://assets/Seasons pack/Spring/Trees/Trees_Spring.png"
]

func _ready():
	texture_id = 0
	last_id = 0

func _process(_delta: float) -> void:
	if texture_id != last_id:
		last_id = texture_id
		tree.texture = load(textures[texture_id])

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		fruit.emit_signal("fruit_fall")

func next_season():
	texture_id = (texture_id + 1) % 4
