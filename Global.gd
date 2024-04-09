extends Node

var path_buffer
var shape_buffer
var next_cell_id = 0
var world = {}
var cells = {}
var paused = true
var cell_selected = -1


var rules = {
	"birth": {3:true},
	"survive": {2:true, 3:true}
}

# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
