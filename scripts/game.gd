extends Node2D

const PEANUT_PLANT = preload("uid://di3dhcufjthht")
var current_peanut_plants: int = 0

@onready var peanut_count_label: Label = $"CanvasLayer/Top Bar/Peanut Count"
@onready var money_label: Label = $"CanvasLayer/Top Bar/Money"
@onready var buy_plant_button: Button = $"CanvasLayer/Right Bar/Buy Plant/Buy Plant Button"
@onready var buy_plant_label: Label = $"CanvasLayer/Right Bar/Buy Plant/Buy Plant Label"
@onready var plant_spawn_points: Array = $"Peanut Plant Spawns".get_children()


var peanut_count: int = 0
var peanut_cost: int = 1
var money: int = 0
var plant_costs_array: Array = [5, 10, 20, 60, 120, 256]
var plant_cost: int = plant_costs_array[0]
var max_peanut_plants: int

func _ready():
	max_peanut_plants = plant_spawn_points.size()
	spawn_peanut_plant(plant_spawn_points[0])
	update_ui()
	
func update_ui() -> void:
	peanut_count_label.text = "Peanuts: " + str(peanut_count)
	money_label.text = "Money: $" + str(money)
	
	if current_peanut_plants >= max_peanut_plants:
		buy_plant_label.text = "Out Of Stock!"
	else:
		buy_plant_label.text = "Peanut Plant: $" + str(plant_cost)

	buy_plant_button.disabled = (money < plant_cost) or current_peanut_plants >= max_peanut_plants
	
	
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
	if current_peanut_plants < max_peanut_plants:
		money -= plant_cost
		if current_peanut_plants < max_peanut_plants - 1:
			plant_cost = plant_costs_array[current_peanut_plants]
			
		spawn_peanut_plant(plant_spawn_points[current_peanut_plants])
		update_ui()

func spawn_peanut_plant(marker: Marker2D):
	if current_peanut_plants < max_peanut_plants:
		var new_peanut_plant = PEANUT_PLANT.instantiate()
		new_peanut_plant.picked.connect(_on_peanut_plant_picked)
		new_peanut_plant.position = marker.position
		add_child(new_peanut_plant)
		current_peanut_plants += 1
