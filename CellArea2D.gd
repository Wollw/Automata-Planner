extends Area2D

func _init():
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input_event(viewport, event, shape_idx):
	if !Global.paused:
		return
	if event is InputEventMouseButton:
		var cell_id = get_parent().get_parent().cell_id
		if event.button_index == MOUSE_BUTTON_LEFT and event.shift_pressed and event.is_pressed():
			Global.cell_selected = cell_id
		if event.button_index == MOUSE_BUTTON_LEFT and event.shift_pressed and event.is_released():
			if Global.cell_selected < 0:
				return
			else:
				if Global.cell_selected == cell_id:
					Global.cell_selected = -1
				else:
					if !Global.world[cell_id].has(Global.cell_selected):
						get_parent().get_parent().add_neighbor(Global.cell_selected)
					else:
						get_node("/root/Node2D").remove_child(Global.world[Global.cell_selected][cell_id])
						Global.world[Global.cell_selected].erase(cell_id)
						Global.world[cell_id].erase(Global.cell_selected)
			Global.cell_selected = -1

		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			if !event.ctrl_pressed and !event.shift_pressed:
				get_parent().get_parent().state = !get_parent().get_parent().state
