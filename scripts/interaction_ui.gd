extends CanvasLayer

const COMMAND_LABEL = 'Aperte "E" '

@onready var ui: CanvasLayer = self
@onready var prompt: Label = $MarginContainer/PanelContainer/Prompt

func _ready():
	ui.visible = false
	EventController.interactable.connect(_on_interactable)
	
func _on_interactable(node: Node, label: String) -> void:
	if node != null:
		ui.visible = true
		prompt.text = COMMAND_LABEL + label
	else:
		ui.visible = false
