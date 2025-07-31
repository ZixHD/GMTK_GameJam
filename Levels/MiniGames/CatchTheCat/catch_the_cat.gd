extends Node
@onready var cat: CharacterBody2D = $Cat
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var end_screen: TextureRect = $EndScreen
@onready var label: Label = $EndScreen/Label


@export var fall_gravity: float = 980.0
var is_falling: bool = false
var velocity: Vector2 = Vector2.ZERO
var game_end: bool = false;

func _ready() -> void:
	print("rdy")
	animation_player.play("loop")
	
	
func _process(delta: float) -> void:
	if !game_end:
		if Input.is_action_just_pressed("ui_accept"):
			start_falling()
			
		if is_falling:
			cat.velocity.y += fall_gravity * delta
			cat.move_and_slide()
			
		
func start_falling() -> void:
	is_falling = true
	velocity = Vector2.ZERO


func _on_kill_zone_body_entered(body: Node2D) -> void:
	game_end = true;
	print("game_lost")
	animation_player.pause()
	end_screen.visible = true;
	label.text = "You failed. Retry?"
	#add a call to GameManager to retry



func _on_bucket_body_entered(body: Node2D) -> void:
	game_end = true;
	cat.velocity = Vector2.ZERO
	animation_player.pause()
	end_screen.visible = true;
	label.text = "You caught the cat!"
	print("game_won")
	
