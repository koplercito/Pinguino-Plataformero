extends CharacterBody2D
var JUMP_VELOCITY = -350.0
var speed = 200
var max_speed = 600
var acceleration = 30
var friction = 15

func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	var input_dir = Input.get_axis("ui_left", "ui_right")
	
	# Movimiento básico
	if input_dir != 0:
		velocity.x += input_dir * acceleration
	else:
		# Frenado por fricción
		velocity.x = move_toward(velocity.x, 0, friction)

	# Limitar velocidad máxima
	velocity.x = clamp(velocity.x, -max_speed, max_speed)

	# Aplicar gravedad y movimiento
	#velocity.y += 10
	move_and_slide()
