extends Node2D

onready var _inputHandler = get_parent()

func _process(delta):
	if(Input.is_action_just_pressed("Light Jab")):
		_inputHandler._SolveAttackInput(0)
	elif(Input.is_action_just_pressed("Light Kick")):
		_inputHandler._SolveAttackInput(2)


