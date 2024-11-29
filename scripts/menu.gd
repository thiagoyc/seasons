extends Control

@onready var player_cat: AnimatedSprite2D = $"PlayerCat"
@onready var small_cat: AnimatedSprite2D = $"SmallCat"
@onready var pressing_sound_fx: AudioStreamPlayer = $Pressing

@onready var main_menu: PanelContainer = $MainMenu
@onready var options_menu: PanelContainer = $OptionsMenu
@onready var controls_menu: PanelContainer = $ControlsMenu
@onready var sound_menu: PanelContainer = $SoundMenu
@onready var video_menu: PanelContainer = $VideoMenu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main_menu.visible = true
	options_menu.visible = false
	controls_menu.visible = false
	sound_menu.visible = false
	video_menu.visible = false
	
	small_cat.visible = true
	player_cat.visible = true
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


func _on_options_button_pressed() -> void:
	pressing_sound_fx.play()
	main_menu.visible = false
	small_cat.visible = false
	player_cat.visible = false
	options_menu.visible = true
	

func _on_exit_options_button_pressed() -> void:
	pressing_sound_fx.play()
	main_menu.visible = true
	small_cat.visible = true
	player_cat.visible = true
	options_menu.visible = false


func _on_controls_button_pressed() -> void:
	pressing_sound_fx.play()
	options_menu.visible = false
	controls_menu.visible = true


func _on_exit_controls_button_pressed() -> void:
	pressing_sound_fx.play()
	options_menu.visible = true
	controls_menu.visible = false


func _on_sound_button_pressed() -> void:
	pressing_sound_fx.play()
	options_menu.visible = false
	sound_menu.visible = true
	

func _on_exit_sound_button_pressed() -> void:
	pressing_sound_fx.play()
	options_menu.visible = true
	sound_menu.visible = false


func _on_video_button_pressed() -> void:
	pressing_sound_fx.play()
	options_menu.visible = false
	video_menu.visible = true


func _on_exit_video_button_pressed() -> void:
	pressing_sound_fx.play()
	options_menu.visible = true
	video_menu.visible = false
