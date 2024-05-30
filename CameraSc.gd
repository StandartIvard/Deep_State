extends Camera2D

var speed = 200  # Camera movement speed in pixels per second

var zoom_speed = 1  # Camera zoom speed
var min_zoom = 0.1  # Minimum camera zoom level
var max_zoom = 100.0  # Maximum camera zoom level
var zoommargin = 0.3

var zoom_factor = 1.0
var zoompos = Vector2()


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom_in()
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom_out()

func zoom_in():
	zoom.x -= zoom_speed
	zoom.x = clamp(zoom.x, min_zoom, max_zoom) # Adjust these values to limit the minimum and maximum zoom
	zoom.y -= zoom_speed
	zoom.y = clamp(zoom.y, min_zoom, max_zoom) # Adjust these values to limit the minimum and maximum zoom

func zoom_out():
	zoom.x += zoom_speed
	zoom.x = clamp(zoom.x, min_zoom, max_zoom) # Adjust these values to limit the minimum and maximum zoom
	zoom.y += zoom_speed
	zoom.y = clamp(zoom.y, min_zoom, max_zoom) # Adjust these values to limit the minimum and maximum zoom

func _process(delta):
	var velocity = Vector2()

	if Input.is_key_pressed(KEY_A):  # A key
		velocity.x -= 1
	if Input.is_key_pressed(KEY_D):  # D key
		velocity.x += 1
	if Input.is_key_pressed(KEY_W):  # W keya
		velocity.y -= 1
	if Input.is_key_pressed(KEY_S):  # S key
		velocity.y += 1

	velocity = velocity.normalized() * speed * delta

	position += velocity
