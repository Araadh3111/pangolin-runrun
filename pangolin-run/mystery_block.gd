extends StaticBody2D

const TERMITE_SCENE = preload("res://termite.tscn")
const BLOCK_SIZE = 54.0

var used = false
var sprite_start_y = 0.0


func _ready() -> void:
	sprite_start_y = $Sprite2D.position.y
	$BumpZone.body_entered.connect(_on_bump_zone_body_entered)


func _on_bump_zone_body_entered(body: Node2D) -> void:
	if used or not body.is_in_group("player"):
		return
	used = true

	# Grey out and stop the shimmer animation
	$Sprite2D.modulate = Color(0.5, 0.5, 0.5)
	$Sprite2D.stop()
	$Sprite2D.frame = 0

	# Bonk
	var bonk = create_tween()
	bonk.tween_property($Sprite2D, "position:y", sprite_start_y - 10, 0.08)
	bonk.tween_property($Sprite2D, "position:y", sprite_start_y, 0.08)

	call_deferred("spawn_termite")


func spawn_termite() -> void:
	var termite = TERMITE_SCENE.instantiate()
	termite.position = position
	get_parent().add_child(termite)

	termite.monitoring = false
	var rise = create_tween()
	rise.tween_property(termite, "position:y", position.y - BLOCK_SIZE, 0.5)
	rise.tween_callback(func(): termite.monitoring = true)
