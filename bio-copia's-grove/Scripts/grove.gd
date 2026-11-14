extends Node2D

@onready var coin_amount: Label = $"Control/Coin Amount"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Shop.item_purchased.connect($Inventory.add_inventory_item)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	coin_amount.text = str(GameManager.current_coins)
	
