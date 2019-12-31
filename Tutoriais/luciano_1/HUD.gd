extends CanvasLayer

signal start_game

func _ready():
	pass

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()

func show_game_over():
	show_message("GAME OVER")
	yield($MessageTimer, "timeout")
	show_message("JOGUE")
	yield(get_tree().create_timer(1), 'timeout')
	$StartButton.show()

func update_score(score):
	$ScoreLabel.text = str(score)



func _on_MessageTimer_timeout():
	$MessageLabel.hide()


func _on_StartButton_pressed():
	$StartButton.hide()
	$MessageLabel.hide()
	emit_signal("start_game")

