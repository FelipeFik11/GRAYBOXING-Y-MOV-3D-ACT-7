extends Control


func _on_reintentar_pressed():
	get_tree().change_scene_to_file("res://nivel.tscn")


func _on_salir_pressed():
	get_tree().quit()



func _on_Reiniciar_pressed() -> void:
	get_tree().change_scene_to_file("res://nivel.tscn")


func _on_Salir_pressed() -> void:
	get_tree().quit()
