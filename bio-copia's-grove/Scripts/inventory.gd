extends Control

@onready var grid_container: GridContainer = $NinePatchRect/GridContainer
@onready var inventory_slots = grid_container.get_children()

var inventory_items: Array[ShopItemsResource] = []


func _on_inventory_icon_pressed() -> void:
	$Background.visible = true
	$NinePatchRect.visible = true

func _on_back_arrow_pressed() -> void:
	$Background.visible = false
	$NinePatchRect.visible = false

func add_inventory_item(item: ShopItemsResource):
	inventory_items.append(item)
	update_inventory()

func update_inventory():
	for i in inventory_slots.size():
		var slot = inventory_slots[i]
		if i < inventory_items.size():
			var inventory_item = inventory_items[i]
			slot.get_node("Inventory Sprite").texture = inventory_item.item_texture
