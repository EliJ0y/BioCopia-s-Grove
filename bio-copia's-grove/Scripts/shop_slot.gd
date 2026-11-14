extends Panel

signal item_purchased(item: ShopItemsResource)

var shop_item: ShopItemsResource

func get_shop_item(item: ShopItemsResource):
	shop_item = item

func _on_buy_bg_pressed() -> void:
	if GameManager.current_coins > shop_item.item_cost:
		GameManager.current_coins -= shop_item.item_cost
		item_purchased.emit(shop_item)

func _on_info_icon_pressed() -> void:
	$"Info Panel".visible = true
