extends Area2D


func destruir():
	$"..".queue_free()

func detenerObjeto():
	$"..".direccion = Vector2(0,0)
	pass
