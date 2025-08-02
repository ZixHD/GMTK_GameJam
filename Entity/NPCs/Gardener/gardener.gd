extends CharacterBody2D

@onready var animation: AnimationPlayer = $AnimationPlayer
@export var speed: float = 25.0
@onready var timer: Timer = $Timer

var direction: Vector2 = Vector2.ZERO
var max_distance: int = 50
enum state { IDLE, WALK_UP, WALK_DOWN }
var player_state = state.IDLE
var spawn_position: Vector2
var next_direction_after_idle: int = state.WALK_DOWN  
var move: bool = true;
var turn_around: bool = true;

func _ready() -> void:
	spawn_position = global_position
	timer.timeout.connect(_on_timer_timeout)
	timer.wait_time = 3.0
	timer.one_shot = true
	timer.start()
	player_state = state.IDLE
	_update_animation()

func _update_animation():
	match player_state:
		state.IDLE:
			animation.play("idle")
			direction = Vector2.ZERO
		state.WALK_UP:
			animation.play("walk back") 
			direction = Vector2.UP
		state.WALK_DOWN:
			animation.play("walk front")
			direction = Vector2.DOWN

func _process(delta: float) -> void:
	if Engine.time_scale == 1:
		movement(delta)

func movement(delta: float) -> void:
	if move:
		if spawn_position.distance_to(global_position) >= max_distance:
			if direction == Vector2.DOWN:
				next_direction_after_idle = state.WALK_UP
			else:
				next_direction_after_idle = state.WALK_DOWN

			player_state = state.IDLE
			_update_animation()
			move = false
			timer.start()
			return

		velocity = direction * speed
		move_and_slide()

	_update_animation()

func _on_timer_timeout() -> void:
	
	if next_direction_after_idle == 2:
		player_state = state.WALK_DOWN
	else:
		player_state = state.WALK_UP
	move = true
	_update_animation()
	spawn_position = global_position
	
	
