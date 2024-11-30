extends Node2D

var objeto1 = preload("res://Escenarios/ObjetosRevote/Objeto1/objeto_1.tscn")


func _ready():
	randomize()

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		spawn()


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
		print("arriba")
	elif numeroaleatorio == 2:  # Abajo
		newObjeto.global_position.y = $BordesSpawn/BordeAbajo.global_position.y
		var x_aleatoria = rng.randf_range($BordesSpawn/BordeAbajo/A.global_position.x, $BordesSpawn/BordeAbajo/B.global_position.x)
		newObjeto.global_position.x = x_aleatoria
		direccion_inicial = Vector2(0, -1)  # Dirección hacia arriba.
		print("abajo")
	elif numeroaleatorio == 3:  # Izquierda
		newObjeto.global_position.x = $BordesSpawn/BordeIzquierdo.global_position.x
		var y_aleatoria = rng.randf_range($BordesSpawn/BordeIzquierdo/A.global_position.y, $BordesSpawn/BordeIzquierdo/B.global_position.y)
		newObjeto.global_position.y = y_aleatoria
		direccion_inicial = Vector2(1, 0)  # Dirección hacia la derecha.
		print("izquierdo")
	elif numeroaleatorio == 4:  # Derecho
		newObjeto.global_position.x = $BordesSpawn/BordeDerecho.global_position.x
		var y_aleatoria = rng.randf_range($BordesSpawn/BordeDerecho/A.global_position.y, $BordesSpawn/BordeDerecho/B.global_position.y)
		newObjeto.global_position.y = y_aleatoria
		direccion_inicial = Vector2(-1, 0)  # Dirección hacia la izquierda.
		print("derecho")
	newObjeto.direccion = direccion_inicial
