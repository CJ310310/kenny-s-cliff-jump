extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -350.0
const DUCK_SPEED = 0

@onready var animator = $AnimatedSprite2D
@onready var jump = $jump

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		if velocity.y > 0:
			velocity.y = 0

	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump.play()
		velocity.y = JUMP_VELOCITY
		
	var is_ducking = Input.is_action_pressed("duck")

	var direction := Input.get_axis("move_left", "move_right")
	
	if is_ducking:
		velocity.x = direction * DUCK_SPEED
		animator.play("Crouch")
	else:
		if direction != 0:
			velocity.x = direction * SPEED
			if velocity.x > 0:
				animator.flip_h = false
				animator.play("Walk")
			elif velocity.x < 0:
				animator.flip_h = true
				animator.play("Walk")
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			animator.play("Idle")
	
	if velocity.y < 0:
		animator.play("Jump")
	elif velocity.y > 0:
		animator.play("Fall")
	
	move_and_slide()
