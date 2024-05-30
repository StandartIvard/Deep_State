extends CanvasLayer

var sceneName: String = ""
var progress = []
var scene_load_status = 0

func _ready():
	$Button.pressed.connect(rdy)
	$Button.hide()
	if sceneName != "":
		ResourceLoader.load_threaded_request(sceneName)
	else:
		print("Error: sceneName is not set!")

func _process(delta):
	if sceneName != "":
		scene_load_status = ResourceLoader.load_threaded_get_status(sceneName, progress)
		$progress_count.text = str(floor(progress[0] * 100)) + "%"
		if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED:
			$progress_count.hide()
			$Button.show()
		print(str(floor(progress[0] * 100)) + "%")
	else:
		print("Error: sceneName is not set!")

func rdy():
	var newScene = ResourceLoader.load_threaded_get(sceneName)
	get_tree().change_scene_to_packed(newScene)
