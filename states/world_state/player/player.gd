extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 200.0
const JUMP_VELOCITY = -400.0

var direction: float = 0.0

func x_input() -> void:
	if not Transition.input_lock:
		direction = Input.get_axis("ui_left", "ui_right")

		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY
	
func _physics_process(delta: float) -> void:
	x_input()
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
