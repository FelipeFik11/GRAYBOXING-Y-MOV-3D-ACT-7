extends Node3D

var monedas_recolectadas := 0
var monedas_totales := 3


func moneda_recolectada():
	monedas_recolectadas += 1

	print("Monedas: ", monedas_recolectadas, "/", monedas_totales)

	if monedas_recolectadas >= monedas_totales:
		finalizar_juego()


func finalizar_juego():
	print("¡Nivel completado!")

	get_tree().paused = true


func _on_zona_de_borrado_body_entered(body: Node3D) -> void:
	pass # Replace with function body.
