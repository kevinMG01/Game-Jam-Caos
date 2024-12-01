extends Area2D

var cantidadADetener = 1
var tiempoAparicion = 5
var tiempoAgare = 3

var is_rotating = false
var max_rotation_angle = 45  
var objeto_en_area = null 

@onready var newObjeto =$nuewObjeto

@onready var temporizador = $Temporizador

var cantidad = 0

func _ready():
	$temporizador.wait_time = tiempoAparicion
	$temporizador.start()


func _on_area_entered(area):
	if area.is_in_group("objeto"):
		if cantidadADetener == 1:
			cantidadADetener -= 1
			area.detenerObjeto()
			objeto_en_area = area
			newObjeto.add_child(area.get_parent())
			area.get_parent().global_position = newObjeto.global_position



func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				is_rotating = true
			else:
				is_rotating = false
				cantidad = 1

		if event.button_index == MOUSE_BUTTON_RIGHT:
			if event.pressed:
				if objeto_en_area:
					var direccion = ( newObjeto.global_position - global_position)
					objeto_en_area.get_parent().direccion = direccion
					objeto_en_area = null
					get_parent().resorteraActual = 0
					queue_free()


func _process(delta):
	if objeto_en_area:
		objeto_en_area.get_parent().global_position = newObjeto.global_position
	
	if cantidad ==1:
		if is_rotating:
			var direction = get_global_mouse_position() - position
			var desired_rotation = direction.angle()

			# Limitar la rotación a 90 grados (entre -45 y 45)
			rotation = clamp(desired_rotation, -deg_to_rad(max_rotation_angle), deg_to_rad(max_rotation_angle))

	elif cantidad ==0:
		if is_rotating:
			var direction = get_global_mouse_position() - position
			rotation = direction.angle()

	if cantidadADetener == 0:
		$temporizador.wait_time = tiempoAgare

func _on_temporizador_timeout():
	if objeto_en_area:
		var x = randi_range(-1, 1)
		var s= randi_range(-1, 1)
		var direccion_aleatoria = Vector2(x,s ).normalized()

		objeto_en_area.get_parent().direccion = direccion_aleatoria
	get_parent().resorteraActual = 0
	queue_free()
	
	
