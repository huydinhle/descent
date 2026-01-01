extends Area2D

@export var speed := 200.0
var direction: Vector2

func _ready():
	direction = (get_global_mouse_position() - global_position).normalized()
	rotation = direction.angle()
	body_entered.connect(_on_body_entered)

func _physics_process(delta):
	position += direction * speed * delta

func _on_body_entered(body):
	print("Hit:", body)
	if body.is_in_group("terrain"):
		set_physics_process(false)
		Global.player.can_teleport = true
