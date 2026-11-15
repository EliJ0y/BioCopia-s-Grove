extends Node

var total_coins: int = 200
var current_coins: int

var unlocked_items: Array[String]

func _ready() -> void:
	current_coins = total_coins

func _process(delta: float) -> void:
	total_coins = current_coins

func add_unlocked_item(unlocked_item: ShopItemsResource):
	if not unlocked_items.has(unlocked_item.item_name):
		unlocked_items.append(unlocked_item.item_name)
