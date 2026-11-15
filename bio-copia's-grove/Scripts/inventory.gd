extends Control

signal item_to_place(item: ShopItemsResource)

@onready var grid_container: GridContainer = $NinePatchRect/GridContainer
@onready var inventory_slots = grid_container.get_children()

var inventory_items: Array[ShopItemsResource] = []


func _ready() -> void:
	for slot in inventory_slots:
		slot.item_to_place.connect(slot_item_to_place)

func _on_inventory_icon_pressed() -> void:
	$Background.visible = true
	$NinePatchRect.visible = true
	$"../Shop".visible = false
	$"../Grovepedia".visible = false
	$"../Placed Items".visible = false

func _on_back_arrow_pressed() -> void:
	$Background.visible = false
	$NinePatchRect.visible = false
	$"../Shop".visible = true
	$"../Grovepedia".visible = true
	$"../Placed Items".visible = true
	for slot in inventory_slots:
		slot.hide_panel()

func add_inventory_item(item: ShopItemsResource):
	inventory_items.append(item)
	update_inventory()

func update_inventory():
	for i in inventory_slots.size():
		var slot = inventory_slots[i]
		if i < inventory_items.size():
			var inventory_item = inventory_items[i]
			slot.get_inventory_item(inventory_item)
			slot.get_node("Inventory Sprite").texture = inventory_item.item_texture
		else:
			slot.get_inventory_item(null)
			slot.get_node("Inventory Sprite").texture = null

func slot_item_to_place(item: ShopItemsResource):
	$Background.visible = false
	$NinePatchRect.visible = false
	$"../Shop".visible = true
	$"../Grovepedia".visible = true
	$"../Placed Items".visible = true
	item_to_place.emit(item)

func remove_placed_item(item: ShopItemsResource):
	inventory_items.erase(item)
	update_inventory()
