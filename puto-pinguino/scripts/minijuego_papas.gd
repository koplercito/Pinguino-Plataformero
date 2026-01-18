extends Node2D


enum INGREDIENTS {TOMATE, CARNE, HONGO, LECHUGA, EMPTY}

var current_order : Array[INGREDIENTS]

const DIALOGUE_SPRITES : Dictionary[INGREDIENTS, CompressedTexture2D] = {
	INGREDIENTS.TOMATE : preload("uid://br8j2jooqt1p8"),
	INGREDIENTS.CARNE : preload("uid://bt52ii00h3qrr"),
	INGREDIENTS.HONGO : preload("uid://btum1mbr82mxw"),
	INGREDIENTS.LECHUGA : preload("uid://bayjswac3b3rp") }
@onready var dialogue_textures : Array[TextureRect] = [$dialogo/TextureRect, $dialogo/TextureRect2, $dialogo/TextureRect3, $dialogo/TextureRect4]


func _ready() -> void:
	randomize_order()


func randomize_order() -> void:
	current_order = [INGREDIENTS.TOMATE, INGREDIENTS.CARNE, INGREDIENTS.HONGO, INGREDIENTS.LECHUGA]
	for i in dialogue_textures : i.show()
	current_order.shuffle()
	var number_ingredients : float = randi_range(1, 4)
	if number_ingredients < 4: 
		current_order[3] = INGREDIENTS.EMPTY
		if number_ingredients < 3: 
			current_order[2] = INGREDIENTS.EMPTY
			if number_ingredients < 2: current_order[1] = INGREDIENTS.EMPTY
	for i in 4:
		if current_order[i] == 4: dialogue_textures[i].hide()
		else: dialogue_textures[i].texture = DIALOGUE_SPRITES[current_order[i]]
