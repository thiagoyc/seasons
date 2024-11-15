extends Label
	
var lives = 7

func _ready():
	EventController.decrease_life_counter.connect(_on_decrease_life_counter)
	text = str(lives) 

func _on_decrease_life_counter():
	lives -= 1
	text = str(lives)
