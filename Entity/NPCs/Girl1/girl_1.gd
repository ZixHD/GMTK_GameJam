extends CharacterBody2D


@onready var animation: AnimationPlayer = $AnimationPlayer
@export var speed: float = 25.0
@onready var timer: Timer = $Timer

var direction: Vector2 = Vector2.ZERO
var max_distance: int = 50
enum state { IDLE_LEFT, IDLE_RIGHT, WALK_LEFT, WALK_RIGHT }
var player_state = state.IDLE_LEFT
var spawn_position: Vector2
var next_direction_after_idle: int = state.WALK_RIGHT
var move: bool = true;
var turn_around: bool = true;

func _ready() -> void:
	spawn_position = global_position
	timer.timeout.connect(_on_timer_timeout)
	timer.wait_time = 8.0
	timer.one_shot = true
	timer.start()
	_update_animation()

func _update_animation():
	match player_state:
		state.IDLE_LEFT:
			animation.play("idle L")
			direction = Vector2.ZERO
		state.IDLE_RIGHT:
			animation.play("idle R")
			direction = Vector2.ZERO
		state.WALK_LEFT:
			animation.play("walk L")
			direction = Vector2.LEFT
		state.WALK_RIGHT:
			animation.play("walk R") 
			direction = Vector2.RIGHT
		

func _process(delta: float) -> void:
	if Engine.time_scale == 1:
		movement(delta)

func movement(delta: float) -> void:
	if move:
		if spawn_position.distance_to(global_position) >= max_distance:
			if direction == Vector2.LEFT:
				next_direction_after_idle = state.WALK_RIGHT
				player_state = state.IDLE_LEFT
			else:
				next_direction_after_idle = state.WALK_LEFT
				player_state = state.IDLE_RIGHT

			
			_update_animation()
			move = false
			timer.start()
			return

		velocity = direction * speed
		move_and_slide()

	_update_animation()

func _on_timer_timeout() -> void:
	print(next_direction_after_idle)
	if next_direction_after_idle == 3:
		player_state = state.WALK_RIGHT
	else:
		player_state = state.WALK_LEFT
	move = true
	_update_animation()
	spawn_position = global_position
	
	
