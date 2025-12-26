extends State
class_name FallStatePlayer

func _ready():
	animation.play("fall")

func _physics_process(delta):
	host.velocity.y += host.GRAVITY * delta
	
	if Input.is_action_pressed("ui_left"):
		host.velocity.x =  max(host.velocity.x - host.air_acceleration, -host.maximum_speed)
		animation.flip_h = true
	elif Input.is_action_pressed("ui_right"):
		host.velocity.x =  min(host.velocity.x + host.air_acceleration, host.maximum_speed)
		animation.flip_h = false
	else:
		host.velocity.x = lerp(host.velocity.x, 0.0, host.air_deceleration)
	
	host.move_and_slide()
	
	if host.is_on_floor():
		host.change_state("idle")
