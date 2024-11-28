extends Control

@onready var player_cat: AnimatedSprite2D = $"PlayerCat"
@onready var small_cat: AnimatedSprite2D = $"SmallCat"
@onready var pressing_sound_fx: AudioStreamPlayer = $Pressing

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_cat.play("default")
	small_cat.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	pressing_sound_fx.play()
	get_tree().change_scene_to_file("res://scenes/level.tscn")


func _on_quit_button_pressed() -> void:
	pressing_sound_fx.play()
	get_tree().quit()
