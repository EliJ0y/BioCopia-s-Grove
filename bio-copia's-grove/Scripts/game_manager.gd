extends Node

@onready var coin_amount: Label = $"../Control/Coin Amount"
var total_coins: int = 200
var current_coins: int

func _ready() -> void:
	current_coins = total_coins

func _process(delta: float) -> void:
	total_coins = current_coins
