extends Node


signal interactable(node: Node, label: String)
signal interaction(node: Node)

signal shake_camera() 
signal stabilize_camera() 

signal decrease_life_counter()

signal save_item_to_inventory(item_name: String)
signal use_item_of_inventory(item_name: String)
