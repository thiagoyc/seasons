extends Control


@onready var audio_name: Label = $HBoxContainer/AudioName
@onready var audio_value: Label = $HBoxContainer/AudioValue
@onready var h_slider: HSlider = $HBoxContainer/HSlider


@export_enum("Master", "Music", "SFX") var bus_name: String

var bus_index: int = 0

func _ready() -> void:
	get_bus_index_by_name()
	set_name_label()
	set_slider_value()
	
	
func set_name_label() -> void:
	audio_name.text = str(bus_name) + " Volume"
	
	
func set_value_label() -> void:
	audio_value.text = str(h_slider.value * 100)


func get_bus_index_by_name() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)


func set_slider_value() -> void:
	h_slider.value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))
	set_value_label()


func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
	set_value_label()
