extends Label

func _ready():
	EventController.decrease_life_counter.connect(_on_decrease_life_counter)
	text = str(Globals.lives) 

func _on_decrease_life_counter():
	Globals.lives -= 1
	text = str(Globals.lives)
	
	if Globals.lives == 0:
		Globals.defeat()
