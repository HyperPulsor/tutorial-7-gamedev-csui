extends RayCast

var current_collider

func _ready():
	pass

func _process(delta):
	current_collider = get_collider()

	if is_colliding() and current_collider is Interactable:
		if Input.is_action_just_pressed("interact"):
			current_collider.interact()
