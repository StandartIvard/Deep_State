extends Control

@onready var first_time = $time_icon_1/First_time as Button
@onready var loading = preload("res://scenes/loading_scene.tscn") as PackedScene
@onready var second_time = $time_icon_2/Second_time as Button

func _ready():
	first_time.connect("pressed", Callable(self, "_on_first_time_pressed"))
	second_time.connect("pressed", Callable(self, "_on_second_time_pressed"))

func _on_first_time_pressed() -> void:
	start("res://main.tscn")

func _on_second_time_pressed() -> void:
	start("res://scenes/vietnam.tscn")

func start(scene_name: String) -> void:
	var loading_scene_instance = loading.instantiate()
	loading_scene_instance.set("sceneName", scene_name)
	get_tree().root.add_child(loading_scene_instance)
	get_tree().current_scene.queue_free()
	get_tree().current_scene = loading_scene_instance
