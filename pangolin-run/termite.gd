extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.power_up()
		set_deferred("monitoring",false)
		var tween = create_tween()
		tween.tween_property(self,"position:y",position.y - 60, 0.4)
		tween.parallel().tween_property(self,"modulate:a",0.0,0.4)
		tween.tween_callback(queue_free)
