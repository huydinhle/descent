extends Node

func _ready() -> void:
	Global.main = self
	Global.UI = $UI
	add_child(load("res://scenes/objects/world.tscn").instantiate())
