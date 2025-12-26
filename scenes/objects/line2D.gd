extends Line2D

var target
var point
@onready var targetPath = get_parent()
@export var trailLength = 16

func _ready():
	target = get_parent()

func _process(delta):
	global_position = Vector2(0,0)
	global_rotation = 0
	point = Vector2(target.global_position.x, target.global_position.y)
	add_point(point)
	
	while get_point_count() > trailLength:
		remove_point(0)
