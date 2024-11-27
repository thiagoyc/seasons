extends Node2D

@onready var tree: Sprite2D = $Tree
@onready var leaves: CharacterBody2D = $Leaves
@onready var animation: AnimatedSprite2D = $AnimatedSprite2D

const texture_format = "res://assets/Seasons pack/%s/Trees/Trees_%s.png"
var texture
var last_season

signal plant_tree()
signal water_tree()
signal ungrow_tree()
signal make_climbable()
signal make_unclimbable()

var grow_animation_ended = true
var grown = true
var planted = false
var watered = false

var can_climb = false
var climbable = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	last_season = Globals.seasons[Globals.seasons_int]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !grown: 
		tree.visible = false
	
	if grown and can_climb:
		climbable = true
	else: climbable = false
	
	if Globals.seasons[Globals.seasons_int] != last_season:
		last_season = Globals.seasons[Globals.seasons_int]
		texture = texture_format % [last_season, last_season]
		tree.texture = load(texture)
	
	if (
		(Globals.seasons[Globals.seasons_int] == 'Summer'
		or Globals.seasons[Globals.seasons_int] == 'Spring') 
		and planted
		and watered
		and !grown
	):
		grow()
	
	if Globals.seasons[Globals.seasons_int] == 'Autumn' and grown:
		drop_leaves()
	
	if climbable: pass


func _on_plant_tree() -> void:
	planted = true


func _on_water_tree() -> void:
	watered = true


func _on_ungrow_tree() -> void:
	grown = false


func _on_make_climbable() -> void:
	can_climb = true


func _on_make_unclimbable() -> void:
	can_climb = false


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and climbable:
		body.emit_signal("is_on_climbable")


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.emit_signal("not_on_climbable")


func _on_animated_sprite_2d_animation_finished() -> void:
	if animation.animation == "Growing":
		tree.visible = true
		animation.visible = false
		grow_animation_ended = true


func grow() -> void:
	grown = true
	grow_animation_ended = false
	animation.visible = true
	animation.play("Growing")


func drop_leaves() -> void:
	leaves.visible = true
	leaves.emit_signal("leaves_fall")
