extends TextureButton

var inventory_item: ShopItemsResource


func get_inventory_item(item: ShopItemsResource):
	inventory_item = item

func _on_pressed() -> void:
	if inventory_item == null:
		return
	$Panel.visible = true
	$"Panel/Place Object Name".text = "Place " + inventory_item.item_name + "?"

func _on_no_button_pressed() -> void:
	$Panel.visible = false

func _on_yes_button_pressed() -> void:
	pass # Replace with function body.
