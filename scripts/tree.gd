extends Node2D

@onready var tree: Sprite2D = $Tree
@onready var leaves: CharacterBody2D = $Leaves

const texture_format = "res://assets/Seasons pack/%s/Trees/Trees_%s.png"
var texture
var last_season

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	last_season = Globals.seasons[Globals.seasons_int]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Globals.seasons[Globals.seasons_int] != last_season:
		last_season = Globals.seasons[Globals.seasons_int]
		texture = texture_format % [last_season, last_season]
		tree.texture = load(texture)
	
	if Globals.seasons[Globals.seasons_int] == 'Autumn':
		drop_leaves()


func drop_leaves():
	leaves.visible = true
	leaves.emit_signal("leaves_fall")
