extends Control

@onready var player_cat: AnimatedSprite2D = $"PlayerCat"
@onready var pressing_sound_fx: AudioStreamPlayer = $Pressing

signal show_self()
signal hide_self()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_cat.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_menu_button_pressed() -> void:
	pressing_sound_fx.play()
	get_tree().paused = false
	Globals.reset_lives()
	Globals.reset_season()
	
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
	self.visible = false


func _on_again_button_pressed() -> void:
	pressing_sound_fx.play()
	get_tree().paused = false
	
	Globals.reset_lives()
	get_tree().change_scene_to_file("res://scenes/level.tscn")
	self.visible = false


func _on_show_self() -> void:
	get_tree().paused = true
	self.visible = true


func _on_hide_self() -> void:
	get_tree().paused = false
	self.visible = false
