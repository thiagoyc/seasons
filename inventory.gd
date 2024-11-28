extends Panel

onready var item_icon: TextureRect = $ItemIcon

signal inventory_updated

class Item:
	var name: String
	var icon: Texture
	var description: String

	func _init(name, icon, description):
		self.name = name
		self.icon = icon
		self.description = description

var current_item: Item = null

func _ready():
	connect("inventory_updated", self, "_update_inventory_ui")
	_update_inventory_ui()

func add_item(name: String, icon_path: String, description: String):
	current_item = Item.new(name, preload(icon_path), description)
	emit_signal("inventory_updated")

func remove_item():
	current_item = null
	emit_signal("inventory_updated")

func _update_inventory_ui():
	if current_item:
		item_icon.texture = current_item.icon
		item_icon.visible = true
	else:
		item_icon.visible = false

func _input(event):
	if event.is_action_pressed("add_item"):
		add_item("Item Único", "res://icons/item_icon.png", "Descrição do item único.")
	elif event.is_action_pressed("remove_item"):
		remove_item()
