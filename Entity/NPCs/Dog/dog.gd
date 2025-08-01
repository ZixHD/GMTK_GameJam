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
	
	_update_animation()

func _update_animation():
	match player_state:
		state.IDLE:
			animation.play("idle")
			direction = Vector2.ZERO
		
