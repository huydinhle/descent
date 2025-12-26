extends Camera2D

var shake_current_power : float
var shake_duration : float

func _ready() -> void:
	Global.camera = self
	
