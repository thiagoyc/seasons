extends Node2D

@onready var midground: TileMapLayer = $Midground

@onready var game_bar: Control = $"UI Manager/GameBar"


const season_textures = [
	"res://assets/Seasons pack/Summer/Ground/Ground_Summer.png",
	"res://assets/Seasons pack/Autumn/Ground/Ground_Autumn.png",
	"res://assets/Seasons pack/Winter/Ground/Ground_Winter.png",
	"res://assets/Seasons pack/Spring/Ground/Ground_Spring.png"
]
const tree_textures = [
	"res://assets/Seasons pack/Summer/Trees/Trees_Summer.png",
	"res://assets/Seasons pack/Autumn/Trees/Trees_Autumn.png",
	"res://assets/Seasons pack/Winter/Trees/Trees_Winter.png",
	"res://assets/Seasons pack/Spring/Trees/Trees_Spring.png"
]

var i = 0
var last_i

func _ready():
	i = 0
	last_i = 0
	update_terrain()


func _process(_delta: float) -> void:
	if i != last_i:
		last_i = i
		update_terrain()
	

func update_terrain() -> void:
	var floor_texture = load(season_textures[i])
	var floor_source : TileSetSource = midground.tile_set.get_source(0)
	if floor_source is TileSetAtlasSource:
		(floor_source as TileSetAtlasSource).texture = floor_texture
		
	var tree_texture = load(tree_textures[i])
	var tree_source : TileSetSource = midground.tile_set.get_source(1)
	if tree_source is TileSetAtlasSource:
		(tree_source as TileSetAtlasSource).texture = tree_texture
	
	var water_cells_array = midground.get_used_cells_by_id(3)
	var ice_cells_array = midground.get_used_cells_by_id(4)
	
	if i == 2:
		for cell in water_cells_array:
			var atlas_coords = midground.get_cell_atlas_coords(cell)
			midground.set_cell(cell, 4, atlas_coords)
	else:
		for cell in ice_cells_array:
			var atlas_coords = midground.get_cell_atlas_coords(cell)
			midground.set_cell(cell, 3, atlas_coords)
		
	remove_child(midground)
	add_child(midground)


func _on_player_cat_cast_done() -> void:
	i = (i + 1) % 4
	get_tree().call_group("SeasonAffected", "next_season")
