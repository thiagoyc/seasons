extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("You died")
		EventController.decrease_life_counter.emit()
		
		if Globals.lives != 0:
			Engine.time_scale = 0.5
			body.get_node("CollisionShape2D").queue_free()
			timer.start()
	
func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
	Globals.reset_season()
