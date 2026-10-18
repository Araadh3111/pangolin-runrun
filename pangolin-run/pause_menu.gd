extends CanvasLayer

const TITLE_SCENE = "res://start_screen.tscn"


func _ready() -> void:
	hide()
	$VBoxContainer/ResumeButton.pressed.connect(_on_resume)
	$VBoxContainer/RestartButton.pressed.connect(_on_restart)
	$VBoxContainer/TitleButton.pressed.connect(_on_title)
	$VBoxContainer/QuitButton.pressed.connect(_on_quit)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()
		get_viewport().set_input_as_handled()


func toggle_pause() -> void:
	var paused = not get_tree().paused
	get_tree().paused = paused
	visible = paused
	if paused:
		$VBoxContainer/ResumeButton.grab_focus()
	else:
		get_viewport().gui_release_focus()


func _on_resume() -> void:
	toggle_pause()


func _on_restart() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_title() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(TITLE_SCENE)


func _on_quit() -> void:
	get_tree().quit()
