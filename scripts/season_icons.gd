extends TextureRect

const season_icons = [
	"res://assets/UI/season/seasons-1.png",
	"res://assets/UI/season/seasons-2.png",
	"res://assets/UI/season/seasons-3.png",
	"res://assets/UI/season/seasons-4.png"
]

var base_id
var last_id

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for n in 4:
		var testing_texture = load(season_icons[n])
		if texture == testing_texture:
			base_id = n
			last_id = n
			break
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var icon_id = (Globals.seasons_int + base_id) % 4
	if icon_id != last_id:
		last_id = icon_id
		var new_texture = load(season_icons[icon_id])
		texture = new_texture
