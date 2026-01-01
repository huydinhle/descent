extends Area2D
class_name Portal

# Reference to the paired portal (the exit portal)
@export var exit_portal: Portal

# Cooldown to prevent teleport loops (in seconds)
var teleport_cooldown: float = 0.5
var last_teleport_time: float = 0.0

# Visual indicator (optional - you can add a sprite or animation)
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	# Connect the body_entered signal to detect when player enters
	body_entered.connect(_on_body_entered)
	
	# Make sure monitoring is enabled
	monitoring = true
	monitorable = false  # Portals don't need to be detected by other areas

func _on_body_entered(body: Node2D) -> void:
	# Check if it's the player and if we have an exit portal
	if body == Global.player and exit_portal != null:
		# Check cooldown to prevent teleport loops
		var current_time = Time.get_ticks_msec() / 1000.0
		if current_time - last_teleport_time < teleport_cooldown:
			return
		
		# Teleport the player
		teleport_player(body)

func teleport_player(player: CharacterBody2D) -> void:
	if exit_portal == null:
		return
	
	# Update cooldown for both portals to prevent immediate re-entry
	var current_time = Time.get_ticks_msec() / 1000.0
	last_teleport_time = current_time
	exit_portal.last_teleport_time = current_time
	
	# Calculate the offset from portal center to player
	var offset = player.position - position
	
	# Teleport player to exit portal position
	player.position = exit_portal.position + offset
	
	# Optional: Add a visual effect at both portals
	spawn_teleport_effect(position)
	spawn_teleport_effect(exit_portal.position)

func spawn_teleport_effect(effect_position: Vector2) -> void:
	# Reuse the existing teleport particle effect
	if Global.world:
		var particles = load("res://scenes/objects/teleport.tscn").instantiate()
		particles.position = effect_position
		Global.world.add_child(particles)

