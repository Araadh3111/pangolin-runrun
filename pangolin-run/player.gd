extends CharacterBody2D



const JUMP_VELOCITY = -600.0
const WALK_SPEED = 250
const SPRINT_SPEED = 450
const ACCELERATION = 1500
const FRICTION = 600

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y*= 0.5
		 
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	var target_speed = WALK_SPEED
	if Input.is_action_pressed("sprint"):
		target_speed = SPRINT_SPEED
	target_speed*=direction
	if direction != 0:
		velocity.x = move_toward(velocity.x,target_speed,ACCELERATION*delta)
	else:
		velocity.x = move_toward(velocity.x,0,FRICTION* delta)
	move_and_slide()
