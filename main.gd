extends Node2D

@onready var time_label = $"CanvasLayer/Control/timerLabel"

@onready var scene = preload("res://main_menu.tscn") as PackedScene

var irak = preload("res://pngs/irak.png")
var irak_action = preload("res://pngs/irak_action.png")
var iran = preload("res://pngs/iran.png")
var iran_action = preload("res://pngs/iran_action.png")
var israel = preload("res://pngs/israel.png")
var israel_action = preload("res://pngs/israel_action.png")
var jordan = preload("res://pngs/jordan.png")
var jordan_action = preload("res://pngs/jordan_action.png")
var lebanon = preload("res://pngs/lebanon.png")
var lebanon_action = preload("res://pngs/lebanon_action.png")
var syria = preload("res://pngs/syria.png")
var syria_action = preload("res://pngs/syria_action.png")
var egypt = preload("res://pngs/egypt.png")
var egypt_action = preload("res://pngs/egypt_action.png")
var palestine = preload("res://pngs/palestine.png")
var grt_isr = preload("res://pngs/six_days_war/israel_victory.png")
var isr_aft_sdw = preload("res://pngs/six_days_war/israel_real.png")
var ept_aft_sdw = preload("res://pngs/six_days_war/Egypt_real.png")
var isr_aft_sdw_action = preload("res://pngs/israel_real_action.png")
var ept_aft_sdw_action = preload("res://pngs/Egypt_real_action.png")
var grt_ept = preload("res://pngs/war_of_attrition/egypt_victory.png")
var grt_isr_woa = preload("res://pngs/war_of_attrition/israel_victory.png")
var ngrt_egp_woa = preload("res://pngs/war_of_attrition/egypt_loose.png")
var isr_stv_action = preload("res://pngs/six_days_war/israel_victory_action.png")
var isr_lw = preload("res://pngs/arab_uprising/israel_lw.png")
var ept_lw = preload("res://pngs/arab_uprising/egypt_lw.png")
var syr_lw = preload("res://pngs/arab_uprising/syria_lw.png")


var egypt_flag = preload("res://pngs/Egypt_flag.png")
var israel_flag = preload("res://pngs/Israel_flag.png")
var jordan_flag = preload("res://pngs/Jordan_flag.png")
var syria_flag = preload("res://pngs/Syria_flag.png")
var palestine_flag = preload("res://pngs/palestine_flag.png")

var pin = preload("res://pngs/pin.png")

var pause_menue = preload("res://scenes/pause_menue.tscn")

var textures = {"Irak": irak, "Irak_action": irak_action, "Iran": iran, "Iran_action": iran_action, 
"Israel": israel, "Israel_action": israel_action,"Israel_flag": israel_flag, "Jordan": jordan,
"Jordan_action": jordan_action, "Jordan_flag": jordan_flag,
"Lebanon": lebanon, "Lebanon_action": lebanon_action, "Syria": syria, "Syria_action": syria_action, 
"Syria_flag": syria_flag,"Egypt": egypt, "Egypt_action": egypt_action, "Egypt_flag": egypt_flag,
"Israel_real": isr_aft_sdw, "Israel_real_action": isr_aft_sdw_action,
"Egypt_real": ept_aft_sdw, "Egypt_real_action": ept_aft_sdw_action,
"Israel_victory_action": isr_stv_action}


var conflict_dates = {
	{"day": 01, "month": 06, "year": 1967}: ["Israel", "vs", "Egypt", "Jordan", "Syria", "Six-Day War"],
	{"day": 01, "month": 04, "year": 1969}: ["Israel_real", "vs", "Egypt_real", "War of Attrition"],
	{"day": 01, "month": 03, "year": 1969}: ["Israel", "vs", "Egypt", "Syria", "Arab uprising"],
}

var event_variants = {
	"Six-Day War": [
		"Arab States Triumph",
		"Stalemate and Peace Negotiations",
		"Israel's Triumph"
	],
	"War of Attrition": [
		"Egypt's Triumph",
		"Israel's Triumph",
		"Prolonged Stalemate"
	],
	"Arab uprising": [
		"Israel's Second Triumph",
		"Limited Arab victory",
		"Crush of Israel forces"
	],
}



class Country:
	var status = false
	var victories = []
	
	func _init(arg_status):
		status = arg_status
	
	func check_status():
		return status
	
	func set_status(arg_status):
		status = arg_status
	
	func add_victory(name):
		victories.append(name)


var Israel = Country.new(true)
var Syria = Country.new(true)
var Egypt = Country.new(true)
var Palestine = Country.new(false)
var Irak = Country.new(true)
var Iran = Country.new(true)
var Lebanon = Country.new(true)
var Jordan = Country.new(true)

var all_countries = {
	"Israel": Israel,
	"Syria": Syria,
	"Egypt": Egypt,
	"Palestine": Palestine,
	"Irak": Irak,
	"Iran": Iran,
	"Lebanon": Lebanon,
	"Jordan": Jordan,
	"Israel_real": Israel,
	"Egypt_real": Egypt,
}



var buttons_funcs = {
	"button_man_1": button_man_1,
	"button_man_2": button_man_2,
	"button_man_3": button_man_3
}

var cur_buttons = {}

var timer = {"day": 01, "month": 01, "year": 1967}

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

func _ready():
	time_label.text = timeConnector(timer["day"], timer["month"], timer["year"])
	$CanvasLayer/event.hide()
	$CanvasLayer/endgame.hide()
	speed_buttons_connector()
	$CanvasLayer/pause_menu.hide()

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
	event_main()


func event_main():
	if timer in conflict_dates.keys() and not event_flag:
		var flag = true
		for i in conflict_dates[timer]:
			if i == "vs" or i == conflict_dates[timer][-1] or all_countries[i].status:
				pass
			else:
				flag = false
		if conflict_dates[timer][-1] == "Arab uprising":
			if "Six-Day War" in all_countries[conflict_dates[timer][0]].victories:
				flag = true
			else:
				flag = false
		if flag:
			countries_to_actions(conflict_dates[timer])
		conflict_dates.erase(timer)


func countries_to_actions(countries):
	name = countries.pop_back()
	
	for i in countries:
		if i != "vs":
			var ti = i
			if "_real" in i:
				ti = i.replace("_real", "")
			var sprite = find_child(ti)
			if name == "Arab uprising" and i == "Israel":
				set_texture_cus(sprite, i + "_victory")
			else:
				set_texture_cus(sprite, i)
			if i == countries[0]:
				button_gen(sprite, countries)
		
	var ttimer = timer.duplicate()
	ttimer["month"] += 3
	
	if ttimer["month"] >= 12:
		ttimer["year"] += 1
		ttimer["month"] -= 12
		
	event_timers[ttimer] = name


func set_texture_cus(sprite, name):
	sprite.texture = textures[name + "_action"]


func set_texture_nowar(sprite, name):
	sprite.texture = textures[name]


func button_gen(sprite, countries):
	var tButton = Button.new()
	tButton.icon = pin
	if not "1" in cur_buttons.keys():
		cur_buttons["1"] = tButton
	else:
		cur_buttons[ str( int( cur_buttons.keys()[-1] ) + 1 ) ] = tButton
	tButton.pressed.connect(buttons_funcs["button_man_" + cur_buttons.keys()[-1]].bind([countries, name]))
	add_child(tButton)
	tButton.global_position = sprite.global_position


func timers_checker():
	if timer == {"day": 01, "month": 01, "year": 1972}:
		endgame()
	if timer in event_timers.keys():
		pass
		
func button_man_1(arr):
	speed_flag = 0
	var flag = true
	$"CanvasLayer/event/VBoxContainer/Label".text = arr[1]
	for i in arr[0]:
		if i != "vs":
			if "_real" in i:
				i = i.replace("_real", "")
			if flag:
				var tsprite = TextureRect.new()
				tsprite.texture = textures[i + "_flag"]
				$"CanvasLayer/event/VBoxContainer/HBoxContainer/HBoxContainer".add_child(tsprite)
			else:
				var tsprite = TextureRect.new()
				tsprite.texture = textures[i + "_flag"]
				$"CanvasLayer/event/VBoxContainer/HBoxContainer/HBoxContainer2".add_child(tsprite)
		else:
			flag = false
	$CanvasLayer/event.show()
	arr[0].erase("vs")
	event_manager(arr[1], arr[0], "1")
		

func button_man_2(arr):
	speed_flag = 0
	var flag = true
	for i in arr[0]:
		if i != "vs":
			if "_real" in i:
				i = i.replace("_real", "")
			if flag:
				var tsprite = TextureRect.new()
				tsprite.texture = textures[i + "_flag"]
				$CanvasLayer/event/VBoxContainer/HBoxContainer/HBoxContainer.add_child(tsprite)
			else:
				var tsprite = TextureRect.new()
				tsprite.texture = textures[i + "_flag"]
				$CanvasLayer/event/VBoxContainer/HBoxContainer/HBoxContainer2.add_child(tsprite)
		else:
			flag = false
	$CanvasLayer/event.show()
	arr[0].erase("vs")
	event_manager(arr[1], arr[0], "2")

func button_man_3(arr):
	speed_flag = 0
	var flag = true
	for i in arr[0]:
		if i != "vs":
			if "_real" in i:
				i = i.replace("_real", "")
			if flag:
				var tsprite = TextureRect.new()
				tsprite.texture = textures[i + "_flag"]
				$CanvasLayer/event/VBoxContainer/HBoxContainer/HBoxContainer.add_child(tsprite)
			else:
				var tsprite = TextureRect.new()
				tsprite.texture = textures[i + "_flag"]
				$CanvasLayer/event/VBoxContainer/HBoxContainer/HBoxContainer2.add_child(tsprite)
		else:
			flag = false
	$CanvasLayer/event.show()
	arr[0].erase("vs")
	event_manager(arr[1], arr[0], "3")

func intr_cleaner(pin_indx):
	for i in cur_int_buttons:
		i.queue_free()
	for i in $CanvasLayer/event/VBoxContainer/HBoxContainer/HBoxContainer2.get_children():
		i.queue_free()
	for i in $CanvasLayer/event/VBoxContainer/HBoxContainer/HBoxContainer.get_children():
		i.queue_free()
	cur_int_buttons = []
	cur_buttons.erase(pin_indx)

func event_manager(event_name, countries, pin_indx):
	var tind = 0
	for i in event_variants[event_name]:
		tind += 1
		var tbutton = Button.new()
		tbutton.text = i
		$CanvasLayer/event/VBoxContainer/VBoxContainer.add_child(tbutton)
		match event_name:
			"Six-Day War":
				six_day_war_event(tbutton, tind, countries, pin_indx)
			"War of Attrition":
				war_of_attrition_event(tbutton, tind, countries, pin_indx)
			"Arab uprising":
				arab_rebellion(tbutton, tind, countries, pin_indx)

func six_day_war_event(button, i, countries, pin_indx):
	match i:
		1:
			button.pressed.connect(sdw_ab.bind([countries, pin_indx]))
		2:
			button.pressed.connect(sdw_irl.bind([countries, pin_indx]))
		3:
			button.pressed.connect(sdw_tiw.bind([countries, pin_indx]))
	cur_int_buttons.append(button)

func war_of_attrition_event(button, i, countries, pin_indx):
	match i:
		1:
			button.pressed.connect(woa_egw.bind([countries, pin_indx]))
		2:
			button.pressed.connect(woa_isw.bind([countries, pin_indx]))
		3:
			button.pressed.connect(woa_sta.bind([countries, pin_indx]))
	cur_int_buttons.append(button)

func arab_rebellion(button, i, countries, pin_indx):
	match i:
		1:
			button.pressed.connect(au_ist.bind([countries, pin_indx]))
		2:
			button.pressed.connect(au_law.bind([countries, pin_indx]))
		3:
			pass
	cur_int_buttons.append(button)
	

func sdw_ab(countr):
	for i in countr[0]:
		if i == "Israel":
			var isr = find_child(i)
			isr.texture = palestine
			all_countries["Palestine"].set_status(true)
			all_countries["Israel"].set_status(false)
		else:
			var ctr = find_child(i)
			ctr.texture = textures[i]
	$CanvasLayer/event.hide()
	normal_speed()
	cur_buttons[countr[-1]].queue_free()
	intr_cleaner(countr[-1])
	

func sdw_tiw(countr):
	for i in countr[0]:
		if i == "Israel":
			var isr = find_child(i)
			isr.texture = grt_isr
			isr.global_position = Vector2(155, 432)
		else:
			var ctr = find_child(i)
			ctr.hide()
			all_countries[i].set_status(false)
	all_countries["Israel"].add_victory("Six-Day War")
	$CanvasLayer/event.hide()
	normal_speed()
	cur_buttons[countr[-1]].queue_free()
	intr_cleaner(countr[-1])

func sdw_irl(countr):
	for i in countr[0]:
		if i == "Israel":
			var isr = find_child(i)
			isr.texture = isr_aft_sdw
			isr.global_position = Vector2(180, 401)
		elif i == "Egypt":
			var ept = find_child(i)
			ept.texture = ept_aft_sdw
		else:
			var ctr = find_child(i)
			ctr.texture = textures[i]
	$CanvasLayer/event.hide()
	normal_speed()
	cur_buttons[countr[-1]].queue_free()
	intr_cleaner(countr[-1])

func woa_egw(countr):
	for i in countr[0]:
		i = i.replace("_real", "")
		if i == "Israel":
			var isr = find_child(i)
			isr.hide()
			all_countries[i].set_status(false)
		elif i == "Egypt":
			var ept = find_child(i)
			ept.texture = grt_ept
			ept.global_position = Vector2(64, 507)
	$CanvasLayer/event.hide()
	normal_speed()
	print(cur_buttons[countr[1]])
	cur_buttons[countr[-1]].queue_free()
	intr_cleaner(countr[-1])

func woa_isw(countr):
	for i in countr[0]:
		i = i.replace("_real", "")
		if i == "Israel":
			var isr = find_child(i)
			isr.texture = grt_isr_woa
			isr.global_position = Vector2(124, 480)
		elif i == "Egypt":
			var ept = find_child(i)
			ept.texture = ngrt_egp_woa
	$CanvasLayer/event.hide()
	normal_speed()
	print(cur_buttons[countr[1]])
	cur_buttons[countr[-1]].queue_free()
	intr_cleaner(countr[-1])

func woa_sta(countr):
	$CanvasLayer/event.hide()
	normal_speed()
	cur_buttons[countr[-1]].queue_free()
	intr_cleaner(countr[-1])

func au_ist(countr):
	$CanvasLayer/event.hide()
	normal_speed()
	cur_buttons[countr[-1]].queue_free()
	intr_cleaner(countr[-1])

func au_law(countr):
	$map/Syria.texture = syr_lw
	$map/Egypt.texture = ept_lw
	$map/Israel.texture = isr_lw
	$map/Syria.global_position = Vector2(340, 226)
	$map/Egypt.global_position = Vector2(68, 534)
	$map/Israel.global_position = Vector2(179, 481)
	$map/Syria.show()
	$map/Egypt.show()
	$CanvasLayer/event.hide()
	normal_speed()
	cur_buttons[countr[-1]].queue_free()
	intr_cleaner(countr[-1])

func au_aw(countr):
	pass

func main_menue():
	get_tree().change_scene_to_packed(scene)

func back_to_game():
	$CanvasLayer/pause_menu.hide()
	speed_flag = 2

func endgame():
	$CanvasLayer/endgame.show()
