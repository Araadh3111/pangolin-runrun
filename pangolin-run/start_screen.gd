extends Control

var starting = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("jump") and not starting:
		starting= true
		$StartSound.play()
		await $StartSound.finished
		get_tree().change_scene_to_file("res://main.tscn")
