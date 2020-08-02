extends KinematicBody2D

export var move_speed = 250
var direction = Vector2()

func _physics_process(delta):
	if direction.length() > 0:
		move_and_collide(direction.normalized() * move_speed * delta)
