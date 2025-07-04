extends Control

signal dificultad_seleccionada(nivel: String)

@onready var facil_btn = $VBoxContainer/Facil
@onready var dificil_btn = $VBoxContainer/Dificil

func _ready():
	facil_btn.pressed.connect(_on_facil_pressed)
	dificil_btn.pressed.connect(_on_dificil_pressed)


func _on_facil_pressed():
	_seleccionar("facil")

func _on_dificil_pressed():
	_seleccionar("dificil")

func _seleccionar(nivel: String):
	# Guardamos en Global y persistencia
	Global.set_dificultad(nivel)
	emit_signal("dificultad_seleccionada", nivel)
	queue_free()
