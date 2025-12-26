extends State
class_name RunStatePlayer

var dir : int

func _ready():
	animation.play("run")

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		host.change_state("jump")
	
	host.velocity.y += host.GRAVITY * delta
	
	if Input.is_action_pressed("ui_left"):
		host.velocity.x =  max(host.velocity.x - host.ground_acceleration, -host.maximum_speed)
		animation.flip_h = true
	elif Input.is_action_pressed("ui_right"):
		host.velocity.x =  min(host.velocity.x + host.ground_acceleration, host.maximum_speed)
		animation.flip_h = false
	else:
		host.change_state("idle")

	host.move_and_slide()
