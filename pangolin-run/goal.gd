extends Area2D

@export_file("*.tscn") var next_level = ""

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.win(next_level)
