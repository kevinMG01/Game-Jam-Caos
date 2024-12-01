extends Control









func _on_play_button_down():
	get_tree().change_scene_to_file("res://Escenarios/Nivel/Niveltutorial/nivel_1.tscn")





func _on_salir_button_down():
	get_tree().quit()
	pass # Replace with function body.


func _on_creditos_button_down():
	get_tree().change_scene_to_file("res://Escenarios/Creditos/creditos.tscn")
	pass # Replace with function body.
