extends Control

@export var video: VideoStream
@export var siguiente_escena: String

@onready var player: VideoStreamPlayer = $VideoPlayer

func _ready():
	ResourceLoader.load_threaded_request(siguiente_escena)
	
	player.stream = video
	player.visible = true
	player.play()
	player.finished.connect(_on_video_finished)

func _on_video_finished():
	#get_tree().change_scene_to_file(siguiente_escena)
	# Esperar hasta que la siguiente escena esté cargada
	var load_status = ResourceLoader.load_threaded_get_status(siguiente_escena)
	while load_status == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
		await get_tree().create_timer(0.1).timeout
		load_status = ResourceLoader.load_threaded_get_status(siguiente_escena)
	
	if load_status == ResourceLoader.THREAD_LOAD_LOADED:
		var next_scene = ResourceLoader.load_threaded_get(siguiente_escena)
		get_tree().change_scene_to_packed(next_scene)
	else:
		print("Error cargando escena: ", siguiente_escena)
		# Fallback: Recargar el menú principal
		get_tree().change_scene_to_file("res://,main_menu.tscn")
