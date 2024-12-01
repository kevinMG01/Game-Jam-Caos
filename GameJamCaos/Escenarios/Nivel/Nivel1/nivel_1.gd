extends Node2D



var objeto1 = preload("res://Escenarios/ObjetosRevote/Objeto1/objeto_1.tscn")
@onready var resorte_scene = preload("res://Escenarios/Resortera/resortera.tscn")

@onready var dimencionVictoria = $victoria/MarginContainer

var objetivosPorCumplir = 15
var contador = 0

var objetosEnEscena = 0
var resortesMax = 1
var resorteraActual = 0

func _ready():
	randomize()
	spawnObjetosEnEscena()

func spawn():
	var newObjeto = objeto1.instantiate()

	$BordesSpawn/Objetos.add_child(newObjeto)

	# Asignamos una posición aleatoria dependiendo del borde.
	var numeroaleatorio = randi_range(1, 4)
	var rng = RandomNumberGenerator.new()
	var direccion_inicial : Vector2

	if numeroaleatorio == 1:  # Arriba
		newObjeto.position.y = $BordesSpawn/BordeArriba.global_position.y
		var x_aleatoria = rng.randf_range($BordesSpawn/BordeArriba/A.global_position.x, $BordesSpawn/BordeArriba/B.global_position.x)
		newObjeto.global_position.x = x_aleatoria
		direccion_inicial = Vector2(0, 1)  # Dirección hacia abajo.

	elif numeroaleatorio == 2:  # Abajo
		newObjeto.global_position.y = $BordesSpawn/BordeAbajo.global_position.y
		var x_aleatoria = rng.randf_range($BordesSpawn/BordeAbajo/A.global_position.x, $BordesSpawn/BordeAbajo/B.global_position.x)
		newObjeto.global_position.x = x_aleatoria
		direccion_inicial = Vector2(0, -1)  # Dirección hacia arriba.

	elif numeroaleatorio == 3:  # Izquierda
		newObjeto.global_position.x = $BordesSpawn/BordeIzquierdo.global_position.x
		var y_aleatoria = rng.randf_range($BordesSpawn/BordeIzquierdo/A.global_position.y, $BordesSpawn/BordeIzquierdo/B.global_position.y)
		newObjeto.global_position.y = y_aleatoria
		direccion_inicial = Vector2(1, 0)  # Dirección hacia la derecha.

	elif numeroaleatorio == 4:  # Derecho
		newObjeto.global_position.x = $BordesSpawn/BordeDerecho.global_position.x
		var y_aleatoria = rng.randf_range($BordesSpawn/BordeDerecho/A.global_position.y, $BordesSpawn/BordeDerecho/B.global_position.y)
		newObjeto.global_position.y = y_aleatoria
		direccion_inicial = Vector2(-1, 0)  # Dirección hacia la izquierda.

	newObjeto.direccion = direccion_inicial

func spawnObjetosEnEscena():
	
	while objetosEnEscena <= objetivosPorCumplir:
		spawn()
		objetosEnEscena += 1

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if resorteraActual < resortesMax:
			var clic_pos = get_global_mouse_position()
			var resorte = resorte_scene.instantiate()
			resorte.position = clic_pos
			resorte._input(event)
			add_child(resorte)
			resorteraActual = resortesMax

func _on_salida_area_entered(area):
	if area.is_in_group("objeto"):
		area.destruir()
		contador += 1

