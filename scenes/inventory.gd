extends Node

var inventory_item_paths = {	
	"apple": "MarginContainer/Inventory frame/apple-icon"
}
var current_inventory_item = null

func _ready() -> void:
	_clear_inventory()
	EventController.save_item_to_inventory.connect(_save_item_to_inventory)
	EventController.use_item_of_inventory.connect(_clear_inventory)

func _process(delta: float) -> void:
	pass
	
func _clear_inventory() -> void:
	for item_path in inventory_item_paths.values():
		get_node(item_path).visible = false
	_set_current_inventory_item(null)
		
func _save_item_to_inventory(item_name="") -> void:
	if _get_current_inventory_item() != "": # only one space in the inventory
		_clear_inventory()
		get_node(inventory_item_paths[item_name]).visible = true
		_set_current_inventory_item(item_name)

func _get_current_inventory_item() -> String:
	return current_inventory_item
	
func _set_current_inventory_item(item_name) -> void:
	current_inventory_item = item_name
	
