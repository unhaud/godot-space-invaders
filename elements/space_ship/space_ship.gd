extends CharacterBody2D

const ROCKET_SCENE = preload("res://elements/rocket/rocket.tscn")
const SPEED = 300.0

@onready var shot_timer := $TimerShot

func _physics_process(delta: float):
	if Input.is_action_just_pressed("ui_accept") and can_shoot():
		shot()
	
	var direction := Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * SPEED
	move_and_slide()

func can_shoot():
	return shot_timer.is_stopped()

func shot():
	var rocket = ROCKET_SCENE.instantiate()
	rocket.global_position = global_position + Vector2(0, -30)
	get_tree().root.add_child(rocket)
	shot_timer.start()

func take_damage():
	Globals.change_lives(-1)
