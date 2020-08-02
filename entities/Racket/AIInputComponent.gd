extends Node

class_name AIInputComponent

export (NodePath) var ball_path
onready var ball = get_node(ball_path)

var racket

func _ready():
	racket = get_parent()

func _process(delta):
	calculate_velocity()

func calculate_velocity():
	if not "direction" in racket:
		return
	
	racket.direction = Vector2(0, get_ball_direction())

func get_ball_direction():
	if abs(racket.position.y - ball.position.y) > 20:
		if racket.position.y < ball.position.y:
			return 1
		else:
			return -1
	else:
		return 0
