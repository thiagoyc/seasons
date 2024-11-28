extends Node

var lives = 7

var seasons_int = 0
const seasons = [
	"Summer",
	"Autumn",
	"Winter",
	"Spring"
]

func next_season() -> void:
	seasons_int = (seasons_int + 1) % 4

func reset_season() -> void:
	seasons_int = 0
