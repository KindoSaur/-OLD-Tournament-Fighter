extends KinematicBody2D

var _isCrouched : bool = false
var _isAttacking : bool = false
var _isFlipped : bool = false

var _startedNotingKeys : bool = false
var _notedKeys = []

var _time = 0
var _waitForAmountOfFrames = 13

var _fullyCharged = false

onready var _availableMoveSet = MoveSetManager.Characters[name]
onready var _flippedMoveSet = MoveSetManager.Characters[name + " Flipped"]
onready var _animationPlayer = $AnimationPlayer

var _velocity : Vector2
var _movementSpeed : float = 3500

onready var _gameRef = get_parent()
var _opponent

export var _offsetTillFlip : int = 20

func _input(event):
	if(event is InputEventKey):
		if(event.pressed and not event.echo):
			var key = OS.get_scancode_string(event.scancode)
			if("WASDUJ".find(key) >= 0):
				_time = 0
				_notedKeys.append(key)
				_startedNotingKeys = true

func _process(delta):
	if(_opponent == null):
		_FindOpponent()
	
	if(!_isAttacking):
		
		_FaceOpponent()
		
		if(!_isCrouched):
			if(Input.is_action_pressed("InputLeft")):
				_MovePlayer(-1, delta)
			elif(Input.is_action_pressed("InputRight")):
				_MovePlayer(1, delta)
		
		if(Input.is_action_pressed("InputDown")):
			if(!_isCrouched):
				_animationPlayer.play("Idle To Crouch Animation")
			else:
				_animationPlayer.play("Crouch Idle Animation")
		else:
			if(_isCrouched):
				_animationPlayer.play("Crouch To Idle Animation")
			else:
				_animationPlayer.play("Idle Animation")
	
	if(_startedNotingKeys):
		_time += delta
		if(_time >= delta * _waitForAmountOfFrames):
			_SolveNotedKeys(_notedKeys)

func _SolveAttackInput(var keyPosition):
	if(!_isCrouched):
		if(!_fullyCharged):
			if(_notedKeys[0] == "A" && !_isFlipped || _notedKeys[0] == "D" && _isFlipped):
				_notedKeys.remove(0)
		_SolveNotedKeys(_notedKeys)
		_fullyCharged = false
	elif(_isCrouched):
		if(_notedKeys == _availableMoveSet.keys()[keyPosition]):
			_notedKeys.insert(0, "S")
		_SolveNotedKeys(_notedKeys)

func _SolveNotedKeys(var input = []):
	if(!_isFlipped):
		if(_availableMoveSet.has(input)):
			_animationPlayer.play(_availableMoveSet[input])
			_SetAttackingState(true)
	elif(_isFlipped):
		if(_flippedMoveSet.has(input)):
			_animationPlayer.play(_flippedMoveSet[input])
			_SetAttackingState(true)

	elif(input[input.size() - 1] == "U" || input[input.size() - 1] == "J"):
		var attack = []
		attack.append(input[input.size() - 1])
		_animationPlayer.play(_availableMoveSet[attack])
		_SetAttackingState(true)
	
	_startedNotingKeys = false
	_notedKeys.clear()

func _SetCrouchedState(var input):
	_isCrouched = input

func _SetAttackingState(var input):
	_isAttacking = input
	z_index = 1

func _MovePlayer(var moveDir : int, var delta):
	_velocity = Vector2()
	_velocity.x += moveDir * _movementSpeed * delta
	_velocity = move_and_slide(_velocity)

func _FindOpponent():
	_opponent = _gameRef.get_node(_gameRef.givenOpponent.name)
	_FaceOpponent()

func _FaceOpponent():
	var distanceToOpponent = _opponent.position.x - position.x
	if(distanceToOpponent > _offsetTillFlip):
		scale.x = scale.y * 1 # Normal
		_isFlipped = false
	elif(distanceToOpponent < -_offsetTillFlip):
		scale.x = scale.y * -1 # Flipped
		_isFlipped = true
