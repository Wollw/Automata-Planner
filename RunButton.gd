extends CheckButton


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Global.paused = !button_pressed
	if !Global.paused:
		Global.cell_selected = -1
	pass
