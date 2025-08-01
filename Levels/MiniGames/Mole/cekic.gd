extends Node2D

@export var speed := 400
@export var swing_duration := 0.2
@export var cooldown_duration := 1.0
@export var respawn_delay := 3.0
@onready var dust_particles_jump_left: GPUParticles2D = $Cekic/DustParticlesJumpLeft
@onready var dust_particles_jump_right: GPUParticles2D = $Cekic/DustParticlesJumpRight
@onready var ground_hit: AudioStreamPlayer2D = $"../SFX/GroundHit"

@onready var area: Area2D = $Cekic/Area2D

var can_hit := true


func _spawn_jump_dust() -> void:
	dust_particles_jump_left.restart()
	dust_particles_jump_left.emitting = true
	dust_particles_jump_right.restart()
	dust_particles_jump_right.emitting = true;
	

func _physics_process(delta):
	var move_dir = Vector2.ZERO

	if Input.is_action_pressed("move_right"):
		move_dir.x += 1
	if Input.is_action_pressed("move_left"):
		move_dir.x -= 1
	if Input.is_action_pressed("move_down"):
		move_dir.y += 1
	if Input.is_action_pressed("move_up"):
		move_dir.y -= 1

	position += move_dir.normalized() * speed * delta

func _input(event):
	if event.is_action_pressed("Hit") and can_hit:
		play_hit()

func play_hit():
	can_hit = false

	
	var tween = create_tween()
	tween.tween_property(self, "rotation_degrees", 50, 0.1)
	tween.tween_property(self, "rotation_degrees", 0, 0.1).set_delay(0.1)
	await get_tree().create_timer(0.1).timeout
	area.monitoring = true
	_spawn_jump_dust()
	ground_hit.play()
	#particles
	
	await get_tree().create_timer(swing_duration).timeout
	area.monitoring = false

	await get_tree().create_timer(cooldown_duration).timeout
	can_hit = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("radi")

func _on_area_2d_area_entered(area: Area2D) -> void:
	if not can_hit:
		if area.visible:
			area.visible = false
			get_parent().add_score()
			DamageNumbers.display_number("+1", area.get_node("Marker2D").global_position)
		await get_tree().create_timer(swing_duration).timeout
		area.monitoring = false
		await get_tree().create_timer(respawn_delay).timeout
		
