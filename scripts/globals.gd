extends Node

var lives = 7
var won = false
var lost = false

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
	won = false
	lost = false

func reset_lives() -> void:
	lives = 7
	won = false
	lost = false

func victory() -> void:
	if not lost:
		won = true

func defeat() -> void:
	if not won:
		lost = true
