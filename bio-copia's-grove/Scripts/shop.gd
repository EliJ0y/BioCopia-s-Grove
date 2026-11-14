extends Node2D

var plants_shop_items = preload("res://Resources/Plants Shop/plants_shop_items.tres")
var animals_shop_items = preload("res://Resources/Animals Shop/animals_shop_items.tres")

@onready var margin_container: MarginContainer = $"Shop Panel/MarginContainer"
@onready var grid_container: GridContainer = $"Shop Panel/MarginContainer/ScrollContainer/GridContainer"
@onready var shop_slots = grid_container.get_children()


func _on_shop_icon_pressed() -> void:
	$"Shop Panel".visible = true

func _on_plant_shop_button_pressed() -> void:
	margin_container.visible = true
	show_shop_items(plants_shop_items.items_array)

func _on_animals_shop_button_pressed() -> void:
	margin_container.visible = true
	show_shop_items(animals_shop_items.items_array)

func _on_back_arrow_pressed() -> void:
	if margin_container.visible == true:
		margin_container.visible = false
	else: 
		$"Shop Panel".visible = false

func show_shop_items(shop_items: Array):
	for i in shop_slots.size():
		var slot = shop_slots[i]
		if i < shop_items.size():
			var shop_item = shop_items[i]
			slot.visible = true
			slot.get_node("Shop Item").texture = shop_item.item_texture
			slot.get_node("Cost Value").text = str(shop_item.item_cost)
			slot.get_node("Item Name").text = shop_item.item_name
		else:
			slot.visible = false
