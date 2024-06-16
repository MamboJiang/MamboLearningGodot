extends Area2D

@onready var player_ui = get_node("/root/Game/PlayerUI")

func _on_body_entered(body):
	player_ui.lostlives(body)
