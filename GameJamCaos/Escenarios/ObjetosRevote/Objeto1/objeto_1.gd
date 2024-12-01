extends CharacterBody2D


var direccion :Vector2
@export var velocidad:int



func _ready():
	var sprite_node = $Icon  
	
	var sprites = [
		"res://Sprites/Objetos/objeto1.png",
		"res://Sprites/Objetos/objeto2.png"
	]
	
	var random_index = randi() % sprites.size()  
	sprite_node.texture = load(sprites[random_index])
	pass

func _physics_process(delta):
	velocity = direccion.normalized() * velocidad
	move_and_slide()

func generar_direccion_aleatoria(angulo_min: float, angulo_max: float) -> Vector2:
	var sonidos = [$rebote1, $rebote2, $rebote3]
	var sonido_aleatorio = sonidos[randi() % sonidos.size()]
	sonido_aleatorio.play()
	var angulo_aleatorio = randf_range(angulo_min, angulo_max)  # Ángulo aleatorio dentro del rango
	var nueva_direccion = Vector2(cos(angulo_aleatorio), sin(angulo_aleatorio)).normalized()
	return nueva_direccion


func cambiar_direccion_por_borde(borde_tocado: String):
	var nueva_direccion : Vector2
	
	if borde_tocado == "BordeArriba":
		nueva_direccion = generar_direccion_aleatoria(PI / 4, 3 * PI / 4)  # Ángulo entre 45° y 135° (hacia abajo, izquierda o derecha)
		
	elif borde_tocado == "BordeAbajo":
		nueva_direccion = generar_direccion_aleatoria(-3 * PI / 4, -PI / 4)  # Ángulo entre -135° y -45° (hacia arriba, izquierda o derecha)
		
	elif borde_tocado == "BordeIzquierdo":
		nueva_direccion = generar_direccion_aleatoria(-PI / 4, PI / 4)  # Ángulo entre -45° y 45° (hacia arriba, abajo o derecha)
		
	elif borde_tocado == "BordeDerecho":
		nueva_direccion = generar_direccion_aleatoria(3 * PI / 4, 5 * PI / 4)  # Ángulo entre 135° y 225° (hacia arriba, abajo o izquierda)
	
	direccion = nueva_direccion



func _on_area_2d_area_entered(area):
	if area.is_in_group("BordeArriba"):
		cambiar_direccion_por_borde("BordeArriba")
	if area.is_in_group("BordeAbajo"):
		cambiar_direccion_por_borde("BordeAbajo")
	if area.is_in_group("BordeIzquierdo"):
		cambiar_direccion_por_borde("BordeIzquierdo")
	if area.is_in_group("BordeDerecho"):
		cambiar_direccion_por_borde("BordeDerecho")

