extends TextureButton

var item_being_placed: ShopItemsResource


func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE

func set_item_texture(item: ShopItemsResource):
	item_being_placed = item
	texture_normal = item.item_texture

func set_tint(is_valid: bool):
	if is_valid:
		modulate = Color.WHITE
	else:
		modulate = Color(1, 0.4, 0.4)

func item_placed():
	modulate = Color.WHITE
	mouse_filter = Control.MOUSE_FILTER_STOP
