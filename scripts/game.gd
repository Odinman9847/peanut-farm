extends Node2D
@onready var peanut_count: Label = $"Peanut Count"

var score: int = 0

func _ready():
	update_label()

func increment_score():
	score += 1
	update_label()
	
func update_label():
	peanut_count.text = "Peanuts: " + str(score)
	
func _on_peanut_plant_picked() -> void:
	increment_score()
