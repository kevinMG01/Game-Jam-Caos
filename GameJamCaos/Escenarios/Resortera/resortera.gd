extends Area2D

var cantidadADetener = 1

var  tiempoAparicion = 5
var tiempoAgare = 3

func _ready():
	$temporizador.wait_time = tiempoAparicion
	$temporizador.start()


func _on_area_entered(area):
	if area.is_in_group("objeto"):
		if cantidadADetener == 1:
			cantidadADetener -= 1
			area.detenerObjeto()


func _process(delta):
	if cantidadADetener == 0:
		$temporizador.wait_time = tiempoAgare

func _on_temporizador_timeout():
	queue_free()
	
