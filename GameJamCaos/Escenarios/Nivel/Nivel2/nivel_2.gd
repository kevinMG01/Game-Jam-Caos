extends Node2D

var objeto1 = preload("res://Escenarios/ObjetosRevote/Objeto1/objeto_1.tscn")
var objeto2 = preload("res://Escenarios/ObjetosRevote/Objeto2/objetivo_2.tscn")
@onready var resorte_scene = preload("res://Escenarios/Resortera/resortera.tscn")

@onready var dimencionVictoria = $victoria/MarginContainer
@onready var misionDeBusqueda = $misionBusqueda
@onready var objetivosCumplidosText = $objetivosCumplidos
@onready var textTemporizador = $TextTemporizador


var misionobjeto1 = randi_range(9,15)
var misionobjeto2 = randi_range(9, 15)

var objetivoRojo = 0
var objetivoAzul = 0


var objetivosPorCumplir = 20
var objetivosCumplidos = 0

var objetosEnEscena = 0
var resortesMax = 1
var resorteraActual = 0

var temporizador = 90


var itemazul= 0
var itemrojo= 0

@onready var victoria = $victoria/MarginContainer  # Suponiendo que este es el nodo a escalar

var tiempo_escalado = 0.3  # Tiempo que tomará escalar de 0 a 1
var escala_inicial = Vector2(0, 0)  # Escala inicial (0, 0)
var escala_final = Vector2(1, 1)  # Escala final (1, 1)
var tiempo_transcurrido = 0.0  # Variable para hacer el seguimiento del tiempo

var ganarPerder = ""

func _ready():
	$"victoria/MarginContainer/HBoxContainer/PantallaDeVictoria(1)".visible = false
	$"victoria/MarginContainer/HBoxContainer/PantallaDePerdida(1)".visible = false
	victoria.scale = escala_inicial 
	randomize()
	spawnObjetosEnEscena()
	$"Musica de fondo".play()
	$Timer.wait_time = temporizador
	$Timer.start()
	
func quitarExesoObjetos():
	if objetivoRojo > misionobjeto2:
		objetivoRojo -= 1
	if objetivoAzul > misionobjeto1:
		objetivoAzul -= 1

func queobjetoEntro(item):
	if item == 1:
		objetivoAzul += 1
		itemazul += 1
	elif item == 2:
		objetivoRojo += 1
		itemrojo += 1

func _process(delta):
	quitarExesoObjetos()
	misionDeBusqueda.text = str("Objetivos a recolectar Azul   " + str(objetivoAzul) +" /" + str(misionobjeto1))
	objetivosCumplidosText.text = str("Objetivos a recolectar Azul   " + str(objetivoRojo) +" /" + str(misionobjeto2))

	var tiempoRestante = int($Timer.time_left)  # Obtener el tiempo restante
	textTemporizador.text = "Tiempo: " + str(tiempoRestante)
	
	if tiempoRestante <= 0:
		scalaVictoria(delta)
		$victoria/MarginContainer/HBoxContainer/butonNivel.text = str("Vonver a Menú")
		$"victoria/MarginContainer/HBoxContainer/PantallaDePerdida(1)".visible = true
		ganarPerder = "perder"
	
	if objetivoAzul == misionobjeto1 && objetivoRojo == misionobjeto2:
		scalaVictoria(delta)
		
		$"Sonido de victoria".play()
		$victoria/MarginContainer/HBoxContainer/butonNivel.text = str("Siguiente")
		$"victoria/MarginContainer/HBoxContainer/PantallaDeVictoria(1)".visible = true
		ganarPerder = "ganar"
	while itemazul > 0:
		spawn(objeto1)
		itemazul -= 1
	while itemrojo > 0:
		spawn(objeto2)
		itemrojo -=1

func scalaVictoria(delta):
	if tiempo_transcurrido < tiempo_escalado:
		victoria.scale = lerp(escala_inicial, escala_final, tiempo_transcurrido / tiempo_escalado)
		tiempo_transcurrido += delta
	else:
		get_tree().paused = true

func spawn(rebotes):
	var newObjeto = rebotes.instantiate()

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
	for i in misionobjeto1:
		spawn(objeto1)
	for i in misionobjeto2:
		spawn(objeto2)

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if resorteraActual < resortesMax:
			var clic_pos = get_global_mouse_position()
			var resorte = resorte_scene.instantiate()
			resorte.position = clic_pos
			resorte._input(event)
			add_child(resorte)
			resorteraActual = resortesMax

func _on_timer_timeout():
	$"Game Over".play()
	get_tree().paused = true


func _on_salida_area_entered(area):
	if area.is_in_group("objeto"):
		area.destruir()
		queobjetoEntro(area.get_parent().item)



func _on_buton_nivel_button_down():
	get_tree().paused = false
	if ganarPerder == "perder":
		get_tree().change_scene_to_file("res://Escenarios/Menu/menu.tscn")
	if ganarPerder == "ganar":
		get_tree().change_scene_to_file("res://Escenarios/Creditos/creditos.tscn")


