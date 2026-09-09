extends Area3D


func _on_body_entered(body):
	if body is CharacterBody3D:
		
		get_tree().current_scene.moneda_recolectada()
		
		queue_free()
