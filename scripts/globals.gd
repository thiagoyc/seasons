extends Node

var lives = 7

var seasons_int = 0
const seasons = [
	"Summer",
	"Autumn",
	"Winter",
	"Spring"
]

var inventory_item = ""

func next_season() -> void:
	seasons_int = (seasons_int + 1) % 4

func reset_season() -> void:
	inventory_item = ""
	seasons_int = 0
