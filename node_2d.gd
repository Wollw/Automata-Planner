extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var width = 36
	var height = 36
	get_viewport().size.x = width * 25
	get_viewport().size.y = height * 25
	var size = get_viewport().size
	size.x -= size.x/width
	size.y -= size.y/height

	#for y in height:
	#	for x in width:
	#		var c = Cell.new(x * size.x/width,y * size.y/height,size.x/width-1,size.y/height-1)
	#		Global.cells[y*width+x] = c
	#		add_child(c)
	#		
	#for y in height:
	#	for x in width:
	#		var n = ((y+1)%height)*width + posmod((x-1),width)
	#		Global.cells[y*width+x].add_neighbor(y*width + (x+1)%width)
	#		Global.cells[y*width+x].add_neighbor(n)
	#		Global.cells[y*width+x].add_neighbor(((y+1)%height)*width + (x+1)%width)
	#		Global.cells[y*width+x].add_neighbor(((y+1)%height)*width + x)

	
	var timer = get_node("Timer")
	timer.timeout.connect(func():
		update()
	)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func update():
	var states = {}
	for c in Global.world:
		states[c] = 0;
		for n in Global.world[c]:
			if Global.cells[n].state:
				states[c] += 1
	
	for c in states:
		if Global.rules["birth"].has(states[c]) and !Global.cells[c].state:
			Global.cells[c].state = Global.rules["birth"][states[c]]
		elif Global.rules["survive"].has(states[c]) and Global.cells[c].state:
			Global.cells[c].state = Global.rules["survive"][states[c]]
		else:
			Global.cells[c].state = false


	pass

func _input(event):
	
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_SPACE:
			Global.paused = !Global.paused



	if event is InputEventKey and event.is_released():
		if event.keycode == KEY_CTRL:
			if Global.path_buffer:
				var c = Cell.new(Global.path_buffer)
				Global.cells[c.cell_id] = c
				add_child(c)
				remove_child(Global.shape_buffer)
			Global.path_buffer = false
			Global.shape_buffer = false
	if Global.path_buffer:
		Global.path_buffer.set(Global.path_buffer.size()-1, Vector2(event.position.x - position.x, event.position.y - position.y))
		Global.shape_buffer.points = Global.path_buffer
	if event is InputEventMouseButton:
		var width = 32
		var height = 32
		var x = event.position.x - position.x
		var y = event.position.y - position.y
		
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if event.ctrl_pressed:
				if !Global.path_buffer:
					Global.shape_buffer = Line2D.new()
					Global.shape_buffer.width=2
					Global.path_buffer = PackedVector2Array([Vector2(event.position.x - position.x, event.position.y - position.y)])
					Global.path_buffer.append(Vector2(event.position.x - position.x, event.position.y - position.y))
					Global.shape_buffer.points = Global.path_buffer
					add_child(Global.shape_buffer)
				else:
					Global.path_buffer.append(Vector2(event.position.x - position.x, event.position.y - position.y))
					Global.shape_buffer.points = Global.path_buffer

