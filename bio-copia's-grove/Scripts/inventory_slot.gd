extends TextureButton

signal item_to_place(item: ShopItemsResource)

var inventory_item: ShopItemsResource


func get_inventory_item(item: ShopItemsResource):
	inventory_item = item

func _on_pressed() -> void:
	if inventory_item == null:
		return
	$Panel.visible = true
	$"Panel/Place Object Name".text = "Place " + inventory_item.item_name + "?"

func _on_no_button_pressed() -> void:
	hide_panel()

func _on_yes_button_pressed() -> void:
	hide_panel()
	item_to_place.emit(inventory_item)

func hide_panel():
	$Panel.visible = false
