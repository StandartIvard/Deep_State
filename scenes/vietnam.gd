extends Node2D

@onready var time_label = $"CanvasLayer/Control/timerLabel"

@onready var scene = preload("res://main_menu.tscn") as PackedScene

var pause_menue = preload("res://scenes/pause_menue.tscn")

var timer = {"day": 01, "month": 01, "year": 1954}

var event_timers = {}

var time_passed = 0.0

var speed = [0, 0.25, 0.5]
var speed_flag = 2

var event_flag = false

var cur_int_buttons = []

func timeConnector(d, m, y):
	return str(d) + "-" + str(m) + "-" + str(y)

func normal_speed():
	speed_flag = 2

func double_speed():
	speed_flag = 1

func pause():
	speed_flag = 0

func speed_buttons_connector():
	$CanvasLayer/Control/pause_button.pressed.connect(pause)
	$CanvasLayer/Control/normal_speed.pressed.connect(normal_speed)
	$CanvasLayer/Control/double_speed.pressed.connect(double_speed)
	$CanvasLayer/pause_menu/to_menu.pressed.connect(main_menue)
	$CanvasLayer/pause_menu/continue.pressed.connect(back_to_game)
	$CanvasLayer/endgame/Button.pressed.connect(main_menue)

func audio_playing():
	if $AudioStreamPlayer.playing == false:
		$AudioStreamPlayer.play()

func main_menue():
	get_tree().change_scene_to_packed(scene)

func back_to_game():
	$CanvasLayer/pause_menu.hide()
	speed_flag = 2

func endgame():
	$CanvasLayer/endgame.show()

func timers_checker():
	if timer == {"day": 01, "month": 01, "year": 1972}:
		endgame()
	if timer in event_timers.keys():
		pass

func _ready():
	time_label.text = timeConnector(timer["day"], timer["month"], timer["year"])
	$CanvasLayer/event.hide()
	$CanvasLayer/endgame.hide()
	speed_buttons_connector()
	$CanvasLayer/pause_menu.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		speed_flag = 0
		$CanvasLayer/pause_menu.show()
	audio_playing()
	var cur_speed = speed[speed_flag]
	if cur_speed != 0:
		time_passed += delta

	if time_passed >= cur_speed and cur_speed != 0:
		timer["month"] += 1
		time_passed -= cur_speed

		if timer["month"] > 12:
			timer["month"] = 1
			timer["year"] += 1

	time_label.text = timeConnector(timer["day"], timer["month"], timer["year"])
	timers_checker()
	##event_main()
