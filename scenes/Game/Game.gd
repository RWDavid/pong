extends Node

var player_one_score = 0
var player_two_score = 0
var max_score = 3

func _process(delta):
	if $StartTimer.time_left > 1:
		$HUD/CountdownContainer/CenterContainer/ActionText.set_text(str(round($StartTimer.time_left)))

func _on_Field_goal_left():
	player_two_score += 1
	update_score()
	if player_two_score < max_score:
		start_new_round()
	else:
		show_winner("You Lose!")

func _on_Field_goal_right():
	player_one_score += 1
	update_score()
	if player_one_score < max_score:
		start_new_round()
	else:
		show_winner("You Win!")

func start_new_round():
	$Ball.reset()
	$PlayerRacket.set_position(Vector2(50, 256))
	$AIRacket.set_position(Vector2(976, 256))
	$HUD/CountdownContainer.set_visible(true)
	$StartTimer.start()

func start_new_game():
	player_one_score = 0
	player_two_score = 0
	update_score()
	$FinalScreen.set_visible(false)
	start_new_round()

func _on_StartTimer_timeout():
	$HUD/CountdownContainer.set_visible(false)
	$Ball.set_start_direction()

func update_score():
	$HUD/PointsDisplay/PlayerOneScore.set_text(str(player_one_score))
	$HUD/PointsDisplay/PlayerTwoScore.set_text(str(player_two_score))

func show_winner(message):
	$FinalScreen.set_visible(true)
	$FinalScreen/VBoxContainer/ResultMessage.set_text(message)


func _on_FinalScreen_new_round():
	start_new_game()


func _on_FinalScreen_exit():
	get_tree().quit()


func _on_StartScreen_new_round():
	start_new_game()
	$StartScreen.set_visible(false)

func _on_StartScreen_exit():
	get_tree().quit()
