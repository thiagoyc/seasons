extends Node2D

@onready var midground: TileMapLayer = $Midground

@onready var game_bar: Control = $"UI Manager/GameBar"
@onready var victory: Control = $"UI Manager/Victory"
@onready var defeat: Control = $"UI Manager/Defeat"


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

var last_i

func _ready():
	last_i = -1
	update_terrain()
	victory.visible = false
	defeat.visible = false


func _process(_delta: float) -> void:
	if last_i != Globals.seasons_int:
		last_i = Globals.seasons_int
		update_terrain()
	
	if Globals.won:
		victory.emit_signal("show_self")
		
	if Globals.lost:
		defeat.emit_signal("show_self")


func update_terrain() -> void:
	# Ground texture
	var floor_texture = load(season_textures[Globals.seasons_int])
	var floor_source : TileSetSource = midground.tile_set.get_source(0)
	if floor_source is TileSetAtlasSource:
		(floor_source as TileSetAtlasSource).texture = floor_texture
	
	# Background trees texture
	var tree_texture = load(tree_textures[Globals.seasons_int])
	var tree_source : TileSetSource = midground.tile_set.get_source(1)
	if tree_source is TileSetAtlasSource:
		(tree_source as TileSetAtlasSource).texture = tree_texture
	
	# Lake texture (water/ice)
	var water_cells_array = midground.get_used_cells_by_id(3)
	var ice_cells_array = midground.get_used_cells_by_id(4)
	if Globals.seasons[Globals.seasons_int] == "Winter":
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
	Globals.next_season()
