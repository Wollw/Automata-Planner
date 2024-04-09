extends Area2D

var state
var node_id
func _init():
	node_id = Global.next_cell_id
	Global.next_cell_id += 1
	state = false
	print(Global.next_cell_id)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !state:
		get_parent().color = Color(0.5,0.5,0.5,1)
	else:
		get_parent().color = Color(1,1,1,1)
	pass

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			state = !state
			print(state)
			print(Global.world)
