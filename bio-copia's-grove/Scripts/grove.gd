extends Node2D

@onready var coin_amount: Label = $"Control/Coin Amount"

var cell_size = Vector2(64, 64)
var top_left_corner = Vector2(60, 490)
var grid_columns = 16
var grid_rows = 3

var show_grid = false:
	set(value):
		show_grid = value
		queue_redraw()

var placed_item_scene = preload("res://Scenes/placed_item.tscn")
var item_to_be_placed: ShopItemsResource
var item_getting_placed: TextureButton
var already_filled_cells = {}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Shop.item_purchased.connect($Inventory.add_inventory_item)
	$Shop.item_purchased.connect(GameManager.add_unlocked_item)
	$Inventory.item_to_place.connect(placing_items)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	coin_amount.text = str(GameManager.current_coins)
	if item_getting_placed != null:
		var snapped_position = snap_to_grid(get_global_mouse_position())
		item_getting_placed.position = snapped_position + (cell_size / 2) - (item_getting_placed.size / 2)
		item_getting_placed.set_tint(is_valid_position(snapped_position))

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

func get_cell(snapped_pos: Vector2) -> Vector2i:
	return Vector2i(((snapped_pos - top_left_corner) / cell_size).floor())

func is_valid_position(snapped_pos: Vector2) -> bool:
	return is_inside_grid(snapped_pos) and not already_filled_cells.has(get_cell(snapped_pos))

func placing_items(item: ShopItemsResource):
	item_to_be_placed = item
	show_grid = true
	item_getting_placed = placed_item_scene.instantiate()
	#for ease of setting all the placed items ot false when opening other scenes like shop
	$"Placed Items".add_child(item_getting_placed)
	item_getting_placed.set_item_texture(item)

func _unhandled_input(event: InputEvent) -> void:
	if item_getting_placed == null:
		return
	#checks for the left click and if it's a valid position
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var snapped_pos = snap_to_grid(get_global_mouse_position())
		if is_valid_position(snapped_pos):
			confirm_placement(snapped_pos)

func confirm_placement(snapped_pos: Vector2):
	#mark that the cell is now filled
	already_filled_cells[get_cell(snapped_pos)] = item_getting_placed
	#the func from placed_item scene
	item_getting_placed.item_placed()
	$Inventory.remove_placed_item(item_to_be_placed)
	item_getting_placed = null
	item_to_be_placed = null
	show_grid = false
