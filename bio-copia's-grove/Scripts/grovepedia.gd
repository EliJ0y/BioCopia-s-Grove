extends Node2D

var plants_page_sets = [preload("res://Resources/Grovepedia Pages/Page Sets/plants_set_1.tres")]
var animals_page_sets = []
var food_page_sets = [preload("res://Resources/Grovepedia Pages/Page Sets/food_set_1.tres")]
var toys_page_sets = [preload("res://Resources/Grovepedia Pages/Page Sets/toys_set_1.tres")]

@onready var left_rarity: Label = $"Pages/Left Page/Rarity"
@onready var left_animal_1: TextureButton = $"Pages/Left Page/Animal 1"
@onready var left_animal_1_name: Label = $"Pages/Left Page/Animal 1 Name"
@onready var left_animal_2: TextureButton = $"Pages/Left Page/Animal 2"
@onready var left_animal_2_name: Label = $"Pages/Left Page/Animal 2 Name"
@onready var left_animal_3: TextureButton = $"Pages/Left Page/Animal 3"
@onready var left_animal_3_name: Label = $"Pages/Left Page/Animal 3 Name"
@onready var left_animal_4: TextureButton = $"Pages/Left Page/Animal 4"
@onready var left_animal_4_name: Label = $"Pages/Left Page/Animal 4 Name"

@onready var right_rarity: Label = $"Pages/Right Page/Rarity"
@onready var right_animal_1: TextureButton = $"Pages/Right Page/Animal 1"
@onready var right_animal_1_name: Label = $"Pages/Right Page/Animal 1 Name"
@onready var right_animal_2: TextureButton = $"Pages/Right Page/Animal 2"
@onready var right_animal_2_name: Label = $"Pages/Right Page/Animal 2 Name"
@onready var right_animal_3: TextureButton = $"Pages/Right Page/Animal 3"
@onready var right_animal_3_name: Label = $"Pages/Right Page/Animal 3 Name"
@onready var right_animal_4: TextureButton = $"Pages/Right Page/Animal 4"
@onready var right_animal_4_name: Label = $"Pages/Right Page/Animal 4 Name"


var page_set: Array[GrovepediaArraysResource]
var current_set_index = 0


func _on_grovepedia_pressed() -> void:
	$Pages.visible = true

func _on_plants_pressed() -> void:
	page_set = plants_page_sets

func _on_animals_pressed() -> void:
	pass # Replace with function body.

func _on_food_pressed() -> void:
	page_set = food_page_sets

func _on_toys_pressed() -> void:
	page_set = toys_page_sets

func _on_previous_page_pressed() -> void:
	if $Pages/Food.visible == true:
		$Pages/Food.visible = false 
		$Pages/Toys.visible = false
		$Pages/Plants.visible = true
		$Pages/Animals.visible = true
	else:
		previous_page_set(page_set)

func _on_next_page_pressed() -> void:
	if $Pages/Plants.visible == true:
		$Pages/Plants.visible = false
		$Pages/Animals.visible = false
		$Pages/Food.visible = true
		$Pages/Toys.visible = true
	else:
		next_page_set()

func previous_page_set(page_set: Array):
	if current_set_index < page_set.size():
		update_pages()

func next_page_set():
	if current_set_index > 0:
		update_pages()

func update_pages():
	pass
