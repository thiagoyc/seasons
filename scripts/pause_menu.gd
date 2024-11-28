extends CanvasLayer

@onready var resume_button: Button = $GameMenu/VBoxContainer/ResumeButton
@onready var pressing_sound_fx: AudioStreamPlayer = $Pressing
@onready var options_menu: PanelContainer = $OptionsMenu
@onready var game_menu: PanelContainer = $GameMenu
@onready var controls_menu: PanelContainer = $ControlsMenu
@onready var sound_menu: PanelContainer = $SoundMenu
@onready var video_menu: PanelContainer = $VideoMenu


func _ready() -> void:
	visible = false
	options_menu.visible = false
	controls_menu.visible = false
	sound_menu.visible = false
	video_menu.visible = false


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		visible = true
		get_tree().paused = true
		resume_button.grab_focus()


func _on_resume_button_pressed() -> void:
	pressing_sound_fx.play()
	get_tree().paused = false
	visible = false
	
	
func _on_options_button_pressed() -> void:
	pressing_sound_fx.play()
	game_menu.visible = false
	options_menu.visible = true
	

func _on_exit_options_button_pressed() -> void:
	pressing_sound_fx.play()
	game_menu.visible = true
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


func _on_menu_button_pressed() -> void:
	pressing_sound_fx.play()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
