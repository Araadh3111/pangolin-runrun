extends CharacterBody2D


const JUMP_VELOCITY = -600.0
const WALK_SPEED = 250
const SPRINT_SPEED = 450
const ACCELERATION = 1500
const FRICTION = 600
const FALL_LIMIT = 1200

var start_position
var ants = 0


func _ready() -> void:
	start_position = global_position


func collect_ant() -> void:
	ants += 1
	$CanvasLayer/AntLabel.text = "Ants: " + str(ants)


func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= 0.5

	
	var direction := Input.get_axis("move_left", "move_right")
	if direction > 0:
		$Sprite2D.flip_h = true
	elif direction < 0:
		$Sprite2D.flip_h = false

	
	var target_speed = WALK_SPEED
	if Input.is_action_pressed("sprint"):
		target_speed = SPRINT_SPEED
	target_speed *= direction
	if direction != 0:
		velocity.x = move_toward(velocity.x, target_speed, ACCELERATION * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)

	# Fell in a hole: back to start
	if global_position.y > FALL_LIMIT:
		get_tree().reload_current_scene()
	move_and_slide()
