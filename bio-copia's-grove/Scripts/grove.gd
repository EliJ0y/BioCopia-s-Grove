extends Node2D

@onready var coin_amount: Label = $"Control/Coin Amount"

var cell_size = Vector2(64, 64)
var top_left_corner = Vector2(60, 490)
var grid_columns = 16
var grid_rows = 3

var show_grid = true:
	set(value):
		show_grid = value
		queue_redraw()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Shop.item_purchased.connect($Inventory.add_inventory_item)
	$Shop.item_purchased.connect(GameManager.add_unlocked_item)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	coin_amount.text = str(GameManager.current_coins)
	var snapped_position = snap_to_grid(get_global_mouse_position())
	print(snapped_position, " inside: ", is_inside_grid(snapped_position))

func _draw():
	if !show_grid:
		return
	var grid_colour = Color(0, 0, 0)
	var size = Vector2(grid_columns, grid_rows) * cell_size
	
	#vertical lines
	for x in grid_columns + 1:
		var start = top_left_corner + Vector2(x * cell_size.x, 0)
		draw_line(start, start + Vector2(0, size.y), grid_colour, 3.0)
	
	#horizontal lines
	for y in grid_rows + 1:
		var start = top_left_corner + Vector2(0, y * cell_size.y)
		draw_line(start, start + Vector2(size.x, 0), grid_colour, 3.0)

func snap_to_grid(pos: Vector2) -> Vector2:
	var cell = ((pos - top_left_corner) / cell_size).floor()
	return top_left_corner + cell * cell_size

func is_inside_grid(snapped_pos: Vector2) -> bool:
	var cell = (snapped_pos - top_left_corner) / cell_size
	return (cell.x >= 0 and cell.x < grid_columns) and (cell.y >= 0 and cell.y < grid_rows)
