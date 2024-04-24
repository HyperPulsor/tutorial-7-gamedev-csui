extends KinematicBody

export var speed = 10
export var sprint_move_speed = 25
export var crouch_move_speed = 5
export var acceleration = 5
export var gravity = 0.98
export var jump_power = 30
export var mouse_sensitivity = 0.3

onready var head = $Head
onready var camera = $Head/Camera
onready var pcap = $CollisionShape
onready var hud = $CanvasLayer/GridContainer
onready var hud_state = $CanvasLayer/TextureRect

var velocity = Vector3()
var camera_x_rotation = 0
var default_speed = 10
var crouch_speed = 20
var default_height = 1.5
var crouch_height = 0.5
var hud_state_pos_default
var hud_state_scale_default

func _ready():
	hud_state_pos_default = hud_state.rect_position
	hud_state_scale_default = hud_state.rect_scale
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		head.rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))

		var x_delta = event.relative.y * mouse_sensitivity
		if camera_x_rotation + x_delta > -90 and camera_x_rotation + x_delta < 90:
			camera.rotate_x(deg2rad(-x_delta))
			camera_x_rotation += x_delta

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(delta):
	speed = default_speed
	var head_basis = head.get_global_transform().basis

	var movement_vector = Vector3()
	if Input.is_action_pressed("movement_forward"):
		movement_vector -= head_basis.z
	if Input.is_action_pressed("movement_backward"):
		movement_vector += head_basis.z
	if Input.is_action_pressed("movement_left"):
		movement_vector -= head_basis.x
	if Input.is_action_pressed("movement_right"):
		movement_vector += head_basis.x
		
	if Input.is_action_pressed("sprint"):
		hud_state.rect_position = Vector2(4, 478)
		hud_state.rect_scale = Vector2(0.25, 0.25)
		hud_state.texture = load("res://assets/sprint.png")
		speed = sprint_move_speed
		
	if Input.is_action_just_released("sprint") or Input.is_action_just_released("crouch"):
		hud_state.rect_scale = hud_state_scale_default
		hud_state.rect_position = hud_state_pos_default
		hud_state.texture = load("res://assets/stand.png")
		
	if Input.is_action_pressed("crouch"):
		hud_state.rect_position = Vector2(4, 488)
		hud_state.texture = load("res://assets/crouch.png")
		pcap.shape.height -= crouch_speed * delta
		speed = crouch_move_speed
	else:
		pcap.shape.height += crouch_speed * delta
	
	pcap.shape.height = clamp(pcap.shape.height, crouch_height, default_height)

	movement_vector = movement_vector.normalized()

	velocity = velocity.linear_interpolate(movement_vector * speed, acceleration * delta)
	velocity.y -= gravity

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += jump_power

	velocity = move_and_slide(velocity, Vector3.UP)

func _on_Area_body_entered(body: RigidBody):
	if body is Item:
		SignalManager.emit_signal("item_grabbed", body.item_name)
		body.queue_free()
