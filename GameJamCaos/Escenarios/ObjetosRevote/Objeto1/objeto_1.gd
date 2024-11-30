extends CharacterBody2D


var direccion :Vector2
@export var velocidad:int


func _ready():
	pass

func _physics_process(delta):
	velocity = direccion.normalized() * velocidad
	move_and_slide()

func cambiar_direccion_aleatoria():
	var angulo_aleatorio = randf_range(0, 2 * PI)
	var nueva_direccion = Vector2(cos(angulo_aleatorio), sin(angulo_aleatorio)).normalized()

	if direccion.dot(nueva_direccion) < 0:
		cambiar_direccion_aleatoria()
	else:
		direccion = nueva_direccion
