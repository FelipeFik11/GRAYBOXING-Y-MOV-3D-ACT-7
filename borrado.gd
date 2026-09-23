extends Node3D
@export var velocidad_crecimiento := 4.0

func _process(delta):
	scale += Vector3.ONE * velocidad_crecimiento * delta
