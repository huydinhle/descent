extends Node2D

func _ready() -> void:
	Global.world = self
	$StaticBody2D.add_to_group("terrain")
