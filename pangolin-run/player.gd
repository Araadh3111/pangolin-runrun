extends CharacterBody2D


const JUMP_VELOCITY = -600.0
const WALK_SPEED = 250
const SPRINT_SPEED = 450
const ACCELERATION = 1500
const FRICTION = 600
const FALL_LIMIT = 1200
const BALL_RADIUS = 36.0

@onready var normal_frames: SpriteFrames = $Sprite2D.sprite_frames
const BALL_TEXTURE = preload("res://Assets/Images/rolling.png")
var ball_frames := SpriteFrames.new()
var powered = false
var won = false
var start_position
var ants = 0


func _ready() -> void:
	start_position = global_position
	$PowerTimer.timeout.connect(_on_power_timer_timeout)
	ball_frames.add_frame("default", BALL_TEXTURE)

func collect_ant() -> void:
	ants += 1
	$CanvasLayer/AntLabel.text = "Ants: " + str(ants)


func die() -> void:
	if won:
		return
	get_tree().reload_current_scene()


func win(next_level: String = "") -> void:
	if won:
		return
	won = true
	$CanvasLayer/WinLabel.visible = true
	if next_level != "":
		$CanvasLayer/WinLabel.text = "Level Complete!\nAnts: " + str(ants)
		await get_tree().create_timer(2.0).timeout
		get_tree().change_scene_to_file(next_level)
	else:
		$CanvasLayer/WinLabel.text = "You Win!\nAnts: " + str(ants) + "\nPress R for title"


func power_up() -> void:
	powered = true
	$Sprite2D.sprite_frames = ball_frames
	$PowerTimer.start()
	$Sprite2D.frame = 0

func _on_power_timer_timeout() -> void:
	powered = false
	$Sprite2D.sprite_frames = normal_frames
	$Sprite2D.rotation = 0


func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# After winning: stand still, wait for restart
	if won:
		velocity.x = 0
		move_and_slide()
		if Input.is_action_just_pressed("restart"):
			get_tree().change_scene_to_file("res://start_screen.tscn")
		return

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= 0.5

	# Direction and facing
	var direction := Input.get_axis("move_left", "move_right")
	if direction > 0:
		$Sprite2D.flip_h = true
	elif direction < 0:
		$Sprite2D.flip_h = false
	if direction != 0 or powered:
		$Sprite2D.play()
	else:
		$Sprite2D.stop()
	# Walk / sprint with momentum
	var target_speed = WALK_SPEED
	if Input.is_action_pressed("sprint"):
		target_speed = SPRINT_SPEED
	target_speed *= direction
	if direction != 0:
		velocity.x = move_toward(velocity.x, target_speed, ACCELERATION * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)

	# Roll: spin the ball (w = v / r)
	if powered:
		$Sprite2D.rotation += velocity.x / BALL_RADIUS * delta

	# Fell in a hole
	if global_position.y > FALL_LIMIT:
		die()
		return

	move_and_slide()
