extends Node
class_name StateFactory

var states : Dictionary = {
	"idle" : IdleStatePlayer,
	"run" : RunStatePlayer,
	"jump" : JumpStatePlayer,
	"fall" : FallStatePlayer,
	"knife_throw" : KnifeThrowStatePlayer
}

func get_state(state_name):
	if states.has(state_name):
		return states.get(state_name)
	else:
		printerr("No state ", state_name, " in state factory!")
