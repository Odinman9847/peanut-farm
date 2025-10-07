extends Node2D
@onready var peanut_count_label: Label = $"Peanut Count"
@onready var money_label: Label = $Money

var peanut_count: int = 0
var peanut_cost: int = 1
var money: int = 0

func _ready():
	update_peanut_count_label()

func increment_peanut_count():
	peanut_count += 1
	update_peanut_count_label()
	
func update_peanut_count_label():
	peanut_count_label.text = "Peanuts: " + str(peanut_count)
	
func update_money_label():
	money_label.text = "Money: $" + str(money)
	
func _on_peanut_plant_picked() -> void:
	increment_peanut_count()

func sell_peanuts() -> void:
	money += peanut_count * peanut_cost 
	peanut_count = 0
	update_peanut_count_label()
	update_money_label()


func _on_sell_button_pressed() -> void:
	sell_peanuts()
