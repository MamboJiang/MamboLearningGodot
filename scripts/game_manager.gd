extends Node

var score = 0
var lives = 3

@onready var score_label = $ScoreLabel

func add_point():
	score += 1
	if score == 8:
		score_label.text = "You have collected all coins! Congrats!"
	else:
		score_label.text = "You have collected " + str(score) + " coins, " + str(8-score) + " coins left!"
