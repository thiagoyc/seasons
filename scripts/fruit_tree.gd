extends Node2D

@onready var tree: Sprite2D = $Tree
@onready var fruit: CharacterBody2D = $Fruit
@onready var area_2d: Area2D = $Area2D

var last_id

const textures = [
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
		tree.texture = load(textures[Globals.seasons_int])
		
		if Globals.seasons[Globals.seasons_int] == "Summer":
			fruit.visible = true
		else:
			fruit.visible = false
			fruit.emit_signal("fruit_back_top")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and fruit.visible:
		fruit.emit_signal("fruit_fall")
