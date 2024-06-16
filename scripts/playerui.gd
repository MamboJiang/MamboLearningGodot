extends CanvasLayer

var lives = 3
var coins = 0

@onready var coin_num = $CoinNum
@onready var heart = $Heart
@onready var heart_2 = $Heart2
@onready var heart_3 = $Heart3
@onready var timer = $Timer

func add_coin():
	coins += 1
	coin_num.text = str(coins)

func lostlives(player):
	player.animated_sprite.play("hit")
	lives -= 1
	if lives == 2:
		heart_3.visible = false
	if lives == 1:
		heart_2.visible = false
	if lives == 0:
		heart.visible = false
		player.animated_sprite.play("die")
		player.get_node("CollisionShape2D").queue_free()
		timer.start()





func _on_timer_timeout():
	get_tree().reload_current_scene()
