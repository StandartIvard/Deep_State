extends Control

@onready var start_button = $Button as Button
@onready var game = preload("res://timelines.tscn") as PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	start_button.button_down.connect(start)

func start() -> void:
	get_tree().change_scene_to_packed(game)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
