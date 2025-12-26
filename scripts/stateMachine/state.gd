extends Node
class_name State

var host : CharacterBody2D
var animation

func setup(host):
	self.host = host
	self.animation = host.get_node("AnimatedSprite2D")
