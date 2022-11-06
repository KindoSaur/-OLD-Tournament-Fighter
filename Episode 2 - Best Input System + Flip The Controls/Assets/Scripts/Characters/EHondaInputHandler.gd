extends Node2D

var _holdTime = 0

onready var _inputHandler = get_parent()

func _process(delta):
	if(Input.is_action_just_pressed("Light Jab")):
		_inputHandler._SolveAttackInput(0)
	elif(Input.is_action_just_pressed("Light Kick")):
		_inputHandler._SolveAttackInput(2)
	
	if(Input.is_action_pressed("InputLeft")):
		_PrepareCharge(delta, "A")
	elif(Input.is_action_pressed("InputRight")):
		_PrepareCharge(delta, "D")
	else:
		_holdTime = 0

func _PrepareCharge(var delta, var inputLetter):
	_holdTime += delta
	if(_holdTime >= 2):
		_holdTime = 0
		_inputHandler._notedKeys.insert(0, inputLetter)
		_inputHandler._fullyCharged = true
		print("can Headbutt")
