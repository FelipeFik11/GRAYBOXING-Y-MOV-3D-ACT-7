extends  CharacterBody3D
@export var velocidad := 7.0
@export var aceleracion := 20.0
@export var gravedad := 20.0
@export var fuerza_salto := 8.5
@export var saltos_maximos := 2

var saltos_realizados := 0


func _physics_process(delta):

	# Gravedad
	if not is_on_floor():
		velocity.y -= gravedad * delta
	else:
		saltos_realizados = 0


	# Movimiento
	var input_vector = Input.get_vector(
		"move_left",
		"move_right",
		"move_forward",
		"move_backward"
	)

	var direccion = Vector3(
		input_vector.x,
		0,
		input_vector.y
	)

	direccion = direccion.normalized()

	var objetivo = direccion * velocidad

	velocity.x = move_toward(
		velocity.x,
		objetivo.x,
		aceleracion * delta
	)

	velocity.z = move_toward(
		velocity.z,
		objetivo.z,
		aceleracion * delta
	)


	# Doble salto
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = fuerza_salto
			saltos_realizados = 1

		elif saltos_realizados < saltos_maximos:
			velocity.y = fuerza_salto
			saltos_realizados += 1


	move_and_slide()
