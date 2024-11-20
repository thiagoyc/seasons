extends TextureRect

const season_icons = [
	"res://assets/Seasons Icons/hairymnstr_seasons_summer.svg",
	"res://assets/Seasons Icons/hairymnstr_seasons_autumn.svg",
	"res://assets/Seasons Icons/hairymnstr_seasons_winter.svg",
	"res://assets/Seasons Icons/hairymnstr_seasons_spring.svg"
]

var icon_id = 0
var last_id

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for n in 4:
		var testing_texture = load(season_icons[n])
		if texture == testing_texture:
			icon_id = n
			last_id = n
			break
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if icon_id != last_id:
		last_id = icon_id
		var new_texture = load(season_icons[icon_id])
		texture = new_texture
		
func next_season():
	icon_id = (icon_id + 1) % 4
