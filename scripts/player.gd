extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $AnimatedSprite2D
@onready var hit_timer = Timer.new()

var is_hit = false
var is_dead = false

func _ready():
	# 将 hit_timer 添加到节点树中并连接 timeout 信号
	add_child(hit_timer)
	hit_timer.one_shot = true
	hit_timer.connect("timeout", Callable(self, "_on_hit_timer_timeout"))

func player_move(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
func player_animation():
	if is_dead:
		animated_sprite.play("die")
		return
	if is_hit:
		animated_sprite.play("hit")
		return
	var direction = Input.get_axis("move_left", "move_right")
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")

func _on_hit_timer_timeout():
	is_hit = false

func player_push_box():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().is_in_group("Box"):
			collision.get_collider().apply_central_impulse(-collision.get_normal() * 50)

func _physics_process(delta):
	player_move(delta)
	player_animation()
	move_and_slide()
	player_push_box()
