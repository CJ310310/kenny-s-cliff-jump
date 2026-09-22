extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -320.0

@onready var animator = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		
		if velocity.x >0:
			animator.flip_h = true
			animator.play("Walk")
			
		if velocity.x <0:
			animator.flip_h = false
			animator.play("Walk")
			
		if velocity.y <0:
			animator.play("Jump")
			
		if velocity.y >0:
			animator.play("Jump")
			
			
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animator.play("Idle")
		

	move_and_slide()
