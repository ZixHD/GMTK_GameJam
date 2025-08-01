extends Node2D

@export var mole_visible_time := 2.0
@export var mole_spawn_min := 1.0
@export var mole_spawn_max := 2.5
@export var victory_pause_time := 6.0

@onready var krtina_1: Sprite2D = $Krtina1/Krtina1
@onready var krtina_2: Sprite2D = $Krtina2/Krtina2
@onready var krtina_3: Sprite2D = $Krtina3/Krtina3
@onready var krtina_4: Sprite2D = $Krtina4/Krtina4
@onready var score_label: Label = $score_label
@onready var victory: Label = $victory
@onready var score_up: AudioStreamPlayer2D = $SFX/ScoreUp

@onready var moles = [$Krtina1, $Krtina2, $Krtina3, $Krtina4]
var score := 0
var last_mole_index := -1   # pamti poslednju krticu koja se pojavila

func _ready():
	randomize()
	start_mole_cycle()

func start_mole_cycle():
	mole_timer()

func mole_timer():
	for mole in moles:
		mole.visible = false
		mole.get_node("CollisionShape2D").disabled = true 

	var new_index = pick_new_mole_index()
	var random_mole = moles[new_index]
	last_mole_index = new_index

	random_mole.visible = true
	random_mole.get_node("CollisionShape2D").disabled = false

	await get_tree().create_timer(mole_visible_time).timeout
	random_mole.visible = false
	random_mole.get_node("CollisionShape2D").disabled = false

	var random_vreme = randf_range(mole_spawn_min, mole_spawn_max)
	await get_tree().create_timer(random_vreme).timeout
	print("Sledeća krtica izlazi za: ", random_vreme, " sekundi") 
	mole_timer()

func pick_new_mole_index() -> int:
	var index = randi() % moles.size()
	while index == last_mole_index:
		index = randi() % moles.size()
	return index

func add_score():
	score += 1
	if score_label:
		score_label.text = str(score)
		print("Score: ", score)
		score_up.play()
		#Display Numbers, and sound
		if score >= 5: 
			await score_up.finished
			krtina_1.visible = false
			krtina_2.visible = false
			krtina_3.visible = false
			krtina_4.visible = false	
			victory.visible = true
			get_tree().paused = true
			await get_tree().create_timer(victory_pause_time).timeout
			print("pobeda")
