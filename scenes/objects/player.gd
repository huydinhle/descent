extends CharacterBody2D

const GRAVITY : float = 800.0
var run_speed : float = 200.0
var jump_power : float = 340.0
var ground_acceleration : float = 60.0
var ground_deceleration : float = 0.4
var air_acceleration : float = 15.0
var air_deceleration : float = 0.05
var maximum_speed : float = 120.0
var stateFactory : StateFactory
var state : Node
var is_knife : bool = true
var can_teleport : bool = false

func _ready() -> void:
	Global.player = self
	stateFactory = StateFactory.new()
	change_state("idle")

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_MASK_LEFT and event.is_pressed():
			if is_knife:
				change_state("knife_throw")
			elif can_teleport:
				if can_teleport:
					can_teleport = false
					position = Global.knife.position
					Global.knife.queue_free()
					is_knife = true
					
					var particles = load("res://scenes/objects/teleport.tscn").instantiate()
					particles.position = position
					Global.world.add_child(particles)
		
		if event.button_index == MOUSE_BUTTON_MASK_RIGHT:
			if can_teleport:
				can_teleport = false
				Global.knife.queue_free()
				is_knife = true
	
	if event is InputEventKey and event.is_pressed():
		if event.keycode == KEY_Q:
			if not is_knife:
				Global.knife.queue_free()
				is_knife = true

func change_state(new_state_name):
	if not state == null:
		state.queue_free()
	
	if stateFactory:
		state = stateFactory.get_state(new_state_name).new()
		state.setup(self)
		state.name = new_state_name
		add_child(state)
