extends Entity
class_name Player

@export var speed = 400

@onready var anim = $AnimationPlayer
@onready var sprite_body = $Sprite2DBody

func _ready() -> void:
	pass

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()
