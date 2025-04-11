extends TankBase
class_name ClassicTankController

func _ready():
	# Additional setup for this specific controller
	pass

func handle_movement(delta):
	# Get input
	get_input()
	
	# Handle rotation (tank rotates in place)
	if input_direction.x != 0:
		# Rotate tank body
		tank_body.rotation += input_direction.x * rotation_speed * delta
		
		# Since the whole node rotates, we need to adjust global rotation of the turret
		# to maintain its aim at the mouse
		handle_turret_rotation(delta)
	
	# Handle acceleration and friction
	if input_direction.y != 0:
		# Accelerate
		current_speed = lerp(current_speed, max_speed * -input_direction.y, acceleration * delta)
	else:
		# Apply friction when no input
		current_speed = lerp(current_speed, 0.0, friction)
	
	# Set velocity based on tank's current rotation
	velocity = Vector2(0, current_speed).rotated(tank_body.rotation)
