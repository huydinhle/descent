extends State
class_name KnifeThrowStatePlayer

func _ready():
	animation.play("knife_throw")
	animation.connect("animation_finished", on_animation_finished)

func on_animation_finished():
	var knife = load("res://scenes/objects/knife.tscn").instantiate()
	knife.position = host.position
	Global.knife = knife
	knife.direction = (host.get_global_mouse_position() - (host.position + Vector2(0.0, -12.0))).normalized()
	host.is_knife = false
	Global.world.add_child(knife)
	
	host.change_state("idle")
