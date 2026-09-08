extends CharacterBody3D

@export var velocidad := 7.0
@export var aceleracion := 20.0
@export var gravedad := 20.0
@export var fuerza_salto := 8.5
@export var saltos_maximos := 2
@export var sensibilidad_mouse := 0.003

@onready var camera = $Camera3D

var saltos_realizados := 0
var rotacion_vertical := 0.0


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _input(event):
	if event is InputEventMouseMotion:
		
		# Girar el personaje horizontalmente
		rotate_y(-event.relative.x * sensibilidad_mouse)

		# Girar la cámara verticalmente
		rotacion_vertical -= event.relative.y * sensibilidad_mouse
		
		rotacion_vertical = clamp(
			rotacion_vertical,
			deg_to_rad(-80),
			deg_to_rad(80)
		)

		camera.rotation.x = rotacion_vertical


func _physics_process(delta):

	# GRAVEDAD
	if not is_on_floor():
		velocity.y -= gravedad * delta
	else:
		saltos_realizados = 0


	# MOVIMIENTO
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

	# Hacer que el movimiento siga la dirección
	# hacia donde está mirando el Player
	direccion = transform.basis * direccion
	direccion.y = 0
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


	# DOBLE SALTO
	if Input.is_action_just_pressed("jump"):
		
		if is_on_floor():
			velocity.y = fuerza_salto
			saltos_realizados = 1
		
		elif saltos_realizados < saltos_maximos:
			velocity.y = fuerza_salto
			saltos_realizados += 1


	move_and_slide()
