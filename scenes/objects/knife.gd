extends Area2D

var direction : Vector2
var speed = 200.0

func _ready() -> void:
	look_at(get_global_mouse_position())

func _physics_process(delta: float) -> void:
	position += speed * direction * delta
	
	for body in get_overlapping_bodies():
		if body.is_in_group("terrain"):
			set_physics_process(false)
			Global.player.can_teleport = true
