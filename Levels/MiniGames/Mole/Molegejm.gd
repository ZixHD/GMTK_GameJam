extends Node2D
@onready var krtina_1: Sprite2D = $Krtina1
@onready var krtina_2: Sprite2D = $Krtina2
@onready var krtina_3: Sprite2D = $Krtina3
@onready var krtina_4: Sprite2D = $Krtina4
@onready var score_label: Label = $score_label

@onready var moles = [$Krtina1, $Krtina2, $Krtina3, $Krtina4]
var score := 0

func _ready():
	randomize()
	start_mole_cycle()

func start_mole_cycle():
	mole_timer()

func mole_timer():
	for mole in moles:
		mole.visible = false

	var random_mole = moles[randi() % moles.size()]
	random_mole.visible = true
# stoji 3 sekunde
	await get_tree().create_timer(3.0).timeout
	random_mole.visible = false

	# mole se spawnuje izmedju 1 - 2.5
	await get_tree().create_timer(randf_range(1.0, 2.5)).timeout
	mole_timer()

func add_score():
	score += 1
	if score_label:
		score_label.text = str(score)
		print("Score: ", score)
