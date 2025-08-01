extends Node2D   # ✅ Cekic should be Node2D

@export var speed := 400    
@onready var area: Area2D = $Cekic/Area2D

var is_hitting := false

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
	if event.is_action_pressed("Hit") and not is_hitting:
		play_hit()

func play_hit():
	is_hitting = true
	area.monitoring = true   

	var tween = create_tween()
	tween.tween_property(self, "rotation_degrees", 50, 0.1)
	tween.tween_property(self, "rotation_degrees", 0, 0.1).set_delay(0.1)

	print("Overlapping areas:", area.get_overlapping_areas())

	for mole in area.get_overlapping_areas():
		print("boze")
		if mole.visible:
			mole.visible = false
			print("HIT:", mole.name)
			get_parent().add_score()

#collider after short delay
	await get_tree().create_timer(0.2).timeout
	area.monitoring = false
	is_hitting = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("radi")
	pass # Replace with function body.


func _on_area_2d_area_entered(area: Area2D) -> void:
	if is_hitting:
		if area.visible:
			area.visible = false
			get_parent().add_score()

#collider after short delay
		await get_tree().create_timer(0.2).timeout
		area.monitoring = false
		area.visible = true
		is_hitting = false
		
	
