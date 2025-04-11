extends CharacterBody2D
class_name TankBase

# References to child nodes
@onready var tank_body = $TankBody
@onready var tank_turret = $TankTurret

# Basic tank properties - adjust these for different controller types
@export var max_speed = 200.0
@export var acceleration = 10.0
@export var friction = 0.1
@export var rotation_speed = 2.0
@export var turret_rotation_speed = 3.0

# Movement variables
var current_speed = 0.0
var input_direction = Vector2.ZERO

func _physics_process(delta):
	# Handle tank movement
	handle_movement(delta)
	
	# Handle turret rotation - points toward mouse by default
	handle_turret_rotation(delta)
	
	# Apply movement
	move_and_slide()

func handle_movement(delta):
	# Base movement - should be overridden by specific controller implementations
	pass

func handle_turret_rotation(delta):
	# By default, turret follows mouse position
	var mouse_pos = get_global_mouse_position()
	
	# Calculate angle directly - direction from turret to mouse position
	# a.angle_to_point(b) is equivalent of doing (b - a).angle().
	# PI / 2.0 is needed because the tank_turret points straight up at resting position
	var target_rot = mouse_pos.angle_to_point(tank_turret.global_position) - (PI / 2.0)
	
	# Smoothly rotate turret toward mouse
	var current_rot = tank_turret.global_rotation
	
	# Use lerp_angle for smooth rotation
	tank_turret.global_rotation = lerp_angle(current_rot, target_rot, turret_rotation_speed * delta)

func get_input():
	# Get the input direction (should be overridden by specific controllers)
	input_direction = Vector2.ZERO
	
	if Input.is_action_pressed("up"):
		input_direction.y += 1
	if Input.is_action_pressed("down"):
		input_direction.y -= 1
	if Input.is_action_pressed("left"):
		input_direction.x -= 1
	if Input.is_action_pressed("right"):
		input_direction.x += 1
	
	return input_direction.normalized()
