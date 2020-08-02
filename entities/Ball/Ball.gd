extends KinematicBody2D

export var initial_ball_speed = 300
export var speed_increase = 50
var ball_speed = initial_ball_speed
var hit_counter = 0
var max_hit_counter = 12
var direction = Vector2()

func _ready():
	randomize()

func set_start_direction():
	var x_orientation
	if randf() < 0.5:
		x_orientation = 1
	else:
		x_orientation = -1
	direction = Vector2(x_orientation, rand_range(-1, 1)).normalized()

func _physics_process(delta):
	var collision = move_and_collide(direction * ball_speed * delta)
	if collision:
		direction = direction.bounce(collision.normal)
		if collision.collider.is_in_group("rackets"):
			
			# calculate ball's position relative to paddle height (top = -1, bottom = 1)
			var relative_y = (self.position.y - collision.collider.position.y) / 40.0
			
			# determine ball's new direction based on where the ball hit the paddle
			direction = Vector2(direction.x, relative_y * 0.5).normalized()
			
			# increase ball's speed when it collides with a racket
			if hit_counter <= max_hit_counter:
				hit_counter += 1
				ball_speed += speed_increase
			
			$RacketSound.play()
		else:
			$WallSound.play()

func reset():
	position = Vector2(512, 256)
	direction = Vector2()
	ball_speed = initial_ball_speed
	hit_counter = 0
