extends Node2D
@onready var peanut_count_label: Label = $"CanvasLayer/Top Bar/Peanut Count"
@onready var money_label: Label = $"CanvasLayer/Top Bar/Money"
@onready var buy_plant_button: Button = $"CanvasLayer/Right Bar/Buy Plant/Buy Plant Button"
@onready var buy_plant_label: Label = $"CanvasLayer/Right Bar/Buy Plant/Buy Plant Label"


var peanut_count: int = 0
var peanut_cost: int = 1
var money: int = 0
var plant_cost: int = 5

func _ready():
	update_ui()
	
func update_ui() -> void:
	peanut_count_label.text = "Peanuts: " + str(peanut_count)
	money_label.text = "Money: $" + str(money)
	buy_plant_label.text = "Peanut Plant: $" + str(plant_cost)

func increment_peanut_count():
	peanut_count += 1
	update_ui()
	
func _on_peanut_plant_picked() -> void:
	increment_peanut_count()

func sell_peanuts() -> void:
	money += peanut_count * peanut_cost 
	peanut_count = 0
	update_ui()


func _on_sell_button_pressed() -> void:
	sell_peanuts()


func _on_buy_plant_button_pressed() -> void:
	if money >= plant_cost:
		money -= plant_cost
		update_ui()
