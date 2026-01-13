extends Sprite2D

@onready var falling_key = preload("res://scenes/falling_key.tscn")

@export var key_name :String = ""

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed(key_name):
		CreateFallingKey()


func CreateFallingKey():
	var fk_inst = falling_key.instantiate()
	get_tree().get_root().call_deferred("add_child", fk_inst)
	fk_inst.Setup(global_position.x)
