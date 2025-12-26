extends State
class_name IdleStatePlayer

func _ready():
	animation.play("idle")

func _physics_process(delta):
	if Input.get_axis("ui_left", "ui_right"):
		host.change_state("run")
	elif Input.is_action_just_pressed("ui_accept"):
		host.change_state("jump")
	
	if not host.is_on_floor():
		host.change_state("fall")
	
	host.velocity.y += host.GRAVITY * delta
	host.velocity.x = lerp(host.velocity.x, 0.0, host.ground_deceleration)
	host.move_and_slide()
