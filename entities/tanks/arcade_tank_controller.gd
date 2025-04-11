extends TankBase
class_name ArcadeTankController

func _ready():
	# Additional setup for this specific controller
	pass

func handle_movement(delta):
	# Get input
	input_direction = Vector2.ZERO
	
	if Input.is_action_pressed("up"):
		input_direction.y += 1
	if Input.is_action_pressed("down"):
		input_direction.y -= 1
	
	# Get mouse position and calculate direction
	var mouse_pos = get_global_mouse_position()
	var direction_to_mouse = global_position.direction_to(mouse_pos)
	
	# Smoothly rotate tank body toward mouse when moving forward
	var target_angle = direction_to_mouse.angle()
	
	# Faster rotation when not moving, slower when moving
	var rot_speed = rotation_speed
	if abs(current_speed) > 10:
		rot_speed *= 0.5
	
	# Rotate tank body towards target angle
	tank_body.rotation = lerp_angle(tank_body.rotation, target_angle, rot_speed * delta)
	
	# Handle acceleration and friction
	if input_direction.y != 0:
		# Accelerate
		current_speed = lerp(current_speed, max_speed * -input_direction.y, acceleration * delta)
	else:
		# Apply friction when no input
		current_speed = lerp(current_speed, 0.0, friction)
	
	# Set velocity based on tank's current rotation (forward/backward)
	velocity = Vector2(0, current_speed).rotated(tank_body.rotation)
