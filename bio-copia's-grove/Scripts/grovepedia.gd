extends Node2D

var plants_page_sets = [preload("res://Resources/Grovepedia Pages/Page Sets/plants_set_1.tres"),
						preload("res://Resources/Grovepedia Pages/Page Sets/plants_set_2.tres")]
var animals_page_sets = [preload("res://Resources/Grovepedia Pages/Page Sets/animals_set_1.tres")]
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

@onready var left_page: Node2D = $"Pages/Left Page"
@onready var right_page: Node2D = $"Pages/Right Page"
var pages_open = false
var plants_animals_shown
var food_toys_shown

var page_set: Array = []
var current_set_index = 0


func _on_grovepedia_pressed() -> void:
	plants_animals_shown = false
	food_toys_shown = true
	show_grovepedia_categories()
	pages_open = false
	$Pages.visible = true

func _on_back_arrow_pressed() -> void:
	current_set_index = 0
	open_grovepedia_pages()
	$Pages.visible = false

func show_grovepedia_categories():
	if plants_animals_shown:
		plants_animals_shown = false
		food_toys_shown = true
		$Pages/Plants.visible = false
		$Pages/Animals.visible = false
		$Pages/Food.visible = true
		$Pages/Toys.visible = true
	elif food_toys_shown:
		plants_animals_shown = true
		food_toys_shown = false
		$Pages/Plants.visible = true
		$Pages/Animals.visible = true
		$Pages/Food.visible = false
		$Pages/Toys.visible = false
	else:
		plants_animals_shown = false
		food_toys_shown = false
		$Pages/Plants.visible = false
		$Pages/Animals.visible = false
		$Pages/Food.visible = false
		$Pages/Toys.visible = false

func open_grovepedia_pages():
	if !pages_open:
		pages_open = true
		left_page.visible = true
		right_page.visible = true
	else:
		pages_open = false
		left_page.visible = false
		right_page.visible = false


func _on_plants_pressed() -> void:
	page_set = plants_page_sets
	plants_animals_shown = false
	food_toys_shown = false
	show_grovepedia_categories()
	open_grovepedia_pages()
	update_pages()

func _on_animals_pressed() -> void:
	page_set = animals_page_sets
	plants_animals_shown = false
	food_toys_shown = false
	show_grovepedia_categories()
	open_grovepedia_pages()
	update_pages()

func _on_food_pressed() -> void:
	page_set = food_page_sets
	plants_animals_shown = false
	food_toys_shown = false
	show_grovepedia_categories()
	open_grovepedia_pages()
	update_pages()

func _on_toys_pressed() -> void:
	page_set = toys_page_sets
	plants_animals_shown = false
	food_toys_shown = false
	show_grovepedia_categories()
	open_grovepedia_pages()
	update_pages()

func _on_previous_page_pressed() -> void:
	if food_toys_shown:
		show_grovepedia_categories()
		plants_animals_shown = true
		food_toys_shown = false
	else:
		previous_page_set()

func _on_next_page_pressed() -> void:
	if plants_animals_shown:
		show_grovepedia_categories()
		plants_animals_shown = false
		food_toys_shown = true
	else:
		next_page_set()

func previous_page_set():
	if current_set_index > 0:
		current_set_index -= 1
		update_pages()
	else:
		if pages_open:
			open_grovepedia_pages()
			plants_animals_shown = false
			food_toys_shown = true
			show_grovepedia_categories()

func next_page_set():
	if current_set_index < page_set.size() - 1:
		current_set_index += 1
		update_pages()

func update_pages():
	var current_page_set = page_set[current_set_index]
	var left_page = current_page_set.page_set[0]
	var right_page = current_page_set.page_set[1]
	
	left_rarity.text = left_page.rarity
	left_animal_1.texture_normal = left_page.picture_1_sprite
	left_animal_1_name.text = left_page.picture_1_name
	left_animal_2.texture_normal = left_page.picture_2_sprite
	left_animal_2_name.text = left_page.picture_2_name
	left_animal_3.texture_normal = left_page.picture_3_sprite
	left_animal_3_name.text = left_page.picture_3_name
	left_animal_4.texture_normal = left_page.picture_4_sprite
	left_animal_4_name.text = left_page.picture_4_name
	
	right_rarity.text = right_page.rarity
	right_animal_1.texture_normal = right_page.picture_1_sprite
	right_animal_1_name.text = right_page.picture_1_name
	right_animal_2.texture_normal = right_page.picture_2_sprite
	right_animal_2_name.text = right_page.picture_2_name
	right_animal_3.texture_normal = right_page.picture_3_sprite
	right_animal_3_name.text = right_page.picture_3_name
	right_animal_4.texture_normal = right_page.picture_4_sprite
	right_animal_4_name.text = right_page.picture_4_name
