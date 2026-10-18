extends CharacterBody2D
const SPEED = 200.0

var direction = -1
func _ready()->void:
	update_facing()
	
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity+=get_gravity()*delta
		
	if is_on_floor() and (is_on_wall() or not $EdgeCheck.is_colliding()):
		direction*=-1
		update_facing()
		
	velocity.x = direction*SPEED
	
	if direction != 0:
		$Sprite2D.play()
	else:
		$Sprite2D.stop()
	
	move_and_slide()
func update_facing()->void:
	$Sprite2D.flip_h = direction > 0
	$EdgeCheck.position.x = abs($EdgeCheck.position.x)*direction
	
	$EdgeCheck.force_raycast_update()
	

func _on_hit_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if body.powered:
			queue_free()
		else:
			body.die()
