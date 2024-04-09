class_name Cell extends Polygon2D

var cell_id
var state = false
var is_selected = false
var _poly

func _init(path):
	cell_id = Global.next_cell_id
	Global.next_cell_id += 1
	state = false
	
	Global.world[cell_id] = {}

	_poly = Polygon2D.new()
	_poly.polygon = PackedVector2Array(path)
	_poly.color = Color(0.5,0.5,0.5,1)

	var cell_area = Area2D.new()
	cell_area.set_script(load("res://CellArea2D.gd"))
	_poly.add_child(cell_area)
	
	var cell_coll = CollisionPolygon2D.new()
	cell_coll.polygon = _poly.polygon
	cell_area.add_child(cell_coll)

	add_child(_poly)
	pass

func add_neighbor(nid):
	if nid != cell_id:
		var edge = Line2D.new()
		edge.z_index = -1
		edge.default_color = Color(0,0,0.5,1)
		edge.width = 3
		edge.add_point(get_center())
		edge.add_point(Global.cells[nid].get_center())
		Global.world[cell_id][nid] = edge
		Global.world[nid][cell_id] = edge
		get_parent().add_child(edge)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !state:
		_poly.color = Color(0.5,0.5,0.5,1)
	else:
		_poly.color = Color(0.7,0.7,0.7,1)

func get_center():
	var x = 0
	var y = 0
	var d = 0
	for n in _poly.polygon:
		x += n.x
		y += n.y
		d += 1
	x /= d
	y /=d
	return Vector2(x,y)
