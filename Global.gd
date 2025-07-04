extends Node

var dificultad := "dificil"  # valor por defecto

func _ready():
	_cargar_dificultad_guardada()

func set_dificultad(nueva_dificultad: String):
	dificultad = nueva_dificultad
	# Guardar para web
	if OS.has_feature('web'):
		_guardar_dificultad_web(nueva_dificultad)

func _guardar_dificultad_web(valor: String):
	JavaScriptBridge.eval("""
	try {
		localStorage.setItem('dificultad_godot', '%s');
	} catch(e) {
		console.log('Error guardando dificultad:', e);
	}
	""" % valor)

func _cargar_dificultad_guardada():
	if OS.has_feature('web'):
		var resultado = JavaScriptBridge.eval("""
		try {
			return localStorage.getItem('dificultad_godot') || 'normal';
		} catch(e) {
			console.log('Error cargando dificultad:', e);
			return 'normal';
		}
		""")
		if resultado:
			dificultad = resultado
