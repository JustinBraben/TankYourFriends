extends CharacterBody2D
class_name Entity

# MOVEMENT
var movedir = Vector2(0,0)
var last_movedir = Vector2(0,1)
var last_safe_pos = position

# COMBAT
var health = 100

# SIGNALS
signal health_changed
signal killed

func _ready() -> void:
	add_to_group("entity")
