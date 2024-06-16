extends Area2D

@onready var game_manager = %GameManager
@onready var animation_player = $AnimationPlayer
@onready var player_ui = %PlayerUI

func _on_body_entered(body):
	game_manager.add_point()
	player_ui.add_coin()
	animation_player.play("pickup")
