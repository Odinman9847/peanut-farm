extends Area2D

const PEANUT = preload("uid://knoxb30q2ksv")
var peanut_count: int = 0
var max_peanuts: int
var spawned_peanuts: Array = []


@onready var spawn_points: Array = $Markers.get_children()

func _ready() -> void:
	max_peanuts = spawn_points.size()
	print(max_peanuts)


signal picked

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			if spawned_peanuts.size() > 0:
				var peanut_to_remove = spawned_peanuts.pop_back()
				peanut_to_remove.queue_free()
				peanut_count -= 1
				picked.emit()
			
			


func _on_timer_timeout() -> void:
	if peanut_count < max_peanuts:
		spawn_peanut(spawn_points[peanut_count])
		print("Spawned peanut at marker: ", spawn_points[peanut_count])
		print("Peanut count: ", peanut_count)
		peanut_count += 1
	else:
		print("At max index! Skipping")
		
func spawn_peanut(marker: Marker2D) -> void:
	var new_peanut = PEANUT.instantiate()
	new_peanut.position = marker.position
	add_child(new_peanut)
	spawned_peanuts.append(new_peanut)
