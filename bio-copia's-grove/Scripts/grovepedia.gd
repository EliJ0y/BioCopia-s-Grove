extends Node2D

var plants_page_sets = [preload("res://Resources/Grovepedia Pages/Page Sets/plants_set_1.tres"),
						preload("res://Resources/Grovepedia Pages/Page Sets/plants_set_2.tres")]
var animals_page_sets = [preload("res://Resources/Grovepedia Pages/Page Sets/animals_set_1.tres")]
var food_page_sets = [preload("res://Resources/Grovepedia Pages/Page Sets/food_set_1.tres")]
var toys_page_sets = [preload("res://Resources/Grovepedia Pages/Page Sets/toys_set_1.tres")]

@onready var left_rarity: Label = $"Pages/Left Page/Rarity"
@onready var right_rarity: Label = $"Pages/Right Page/Rarity"

@onready var left_sprites: Array[TextureButton] = [
	$"Pages/Left Page/Sprite 1", $"Pages/Left Page/Sprite 2",
	$"Pages/Left Page/Sprite 3", $"Pages/Left Page/Sprite 4"
]
@onready var left_names: Array[Label] = [
	$"Pages/Left Page/Sprite 1 Name", $"Pages/Left Page/Sprite 2 Name",
	$"Pages/Left Page/Sprite 3 Name", $"Pages/Left Page/Sprite 4 Name"
]
@onready var right_sprites: Array[TextureButton] = [
	$"Pages/Right Page/Sprite 1", $"Pages/Right Page/Sprite 2",
	$"Pages/Right Page/Sprite 3", $"Pages/Right Page/Sprite 4"
]
@onready var right_names: Array[Label] = [
	$"Pages/Right Page/Sprite 1 Name", $"Pages/Right Page/Sprite 2 Name",
	$"Pages/Right Page/Sprite 3 Name", $"Pages/Right Page/Sprite 4 Name"
]

@onready var left_page: Node2D = $"Pages/Left Page"
@onready var right_page: Node2D = $"Pages/Right Page"
var pages_open = false
var plants_sprites_shown
var food_toys_shown

var page_set: Array = []
var current_set_index = 0


func _on_grovepedia_pressed() -> void:
	plants_sprites_shown = false
	food_toys_shown = true
	show_grovepedia_categories()
	pages_open = false
	$Pages.visible = true

func _on_back_arrow_pressed() -> void:
	current_set_index = 0
	open_grovepedia_pages()
	$Pages.visible = false

func show_grovepedia_categories():
	if plants_sprites_shown:
		disable_categories()
		food_toys_shown = true
		$Pages/Food.visible = true
		$Pages/Toys.visible = true
	elif food_toys_shown:
		disable_categories()
		plants_sprites_shown = true
		$Pages/Plants.visible = true
		$Pages/Animals.visible = true
	else:
		disable_categories()

func disable_categories():
	plants_sprites_shown = false
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
	plants_sprites_shown = false
	food_toys_shown = false
	show_grovepedia_categories()
	open_grovepedia_pages()
	update_pages()

func _on_animals_pressed() -> void:
	page_set = animals_page_sets
	plants_sprites_shown = false
	food_toys_shown = false
	show_grovepedia_categories()
	open_grovepedia_pages()
	update_pages()

func _on_food_pressed() -> void:
	page_set = food_page_sets
	plants_sprites_shown = false
	food_toys_shown = false
	show_grovepedia_categories()
	open_grovepedia_pages()
	update_pages()

func _on_toys_pressed() -> void:
	page_set = toys_page_sets
	plants_sprites_shown = false
	food_toys_shown = false
	show_grovepedia_categories()
	open_grovepedia_pages()
	update_pages()

func _on_previous_page_pressed() -> void:
	if food_toys_shown:
		show_grovepedia_categories()
		plants_sprites_shown = true
		food_toys_shown = false
	else:
		previous_page_set()

func _on_next_page_pressed() -> void:
	if plants_sprites_shown:
		show_grovepedia_categories()
		plants_sprites_shown = false
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
			plants_sprites_shown = false
			food_toys_shown = true
			show_grovepedia_categories()

func next_page_set():
	if current_set_index < page_set.size() - 1:
		current_set_index += 1
		update_pages()

func update_pages():
	#gets the correct resource from the preloaded arrays
	var current_page_set = page_set[current_set_index]
	#page gets the correct resource(left/right page) from the array of current_page_set
	fill_page_contacts(left_rarity, left_sprites, left_names, current_page_set.sets_of_pages[0])
	fill_page_contacts(right_rarity, right_sprites, right_names, current_page_set.sets_of_pages[1])

func fill_page_contacts(rarity: Label, sprites: Array, names: Array, page):
	rarity.text = page.rarity
	for i in 4:
		sprites[i].texture_normal = page.sprites[i]
		names[i].text = page.names[i]
