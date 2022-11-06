extends KinematicBody2D

#Integer
export (int) var offsetTillFlip = 20  # How much overlap until the AI will flip
export (int) var AIMovementSpeed = 30 # How fast can the AI move

var moveDir # Current move direction of the AI
var maxDistance = 600 # When is the AI to far away from the target

#Float
var maxMoveTime = 1 # Max allowed move time 
var time = maxMoveTime # Current time until the AI stops moving

var maxTimeTillChoice = 1.2 # Max waiting time until the next choice is made
var countDown = maxTimeTillChoice # Current time until the next choice is made

#Array
var mKeys = [] # Move Keys

#Vector
var velocity = Vector2()  # Current velocity of the AI

#Boolean
var startMoving = false # Check if the AI is allowed to move 
var isCrouching = false # Check if the AI isn't crouching
var _isAttacking = false
#References
var attackMoves = MoveSetManager.Characters[name] # Specific moveset of the current AI

#Object
onready var animPlayer = $AnimationPlayer # Get the AI animation player
onready var gameRef = get_parent()
onready var player = get_parent().get_node(gameRef.givenPlayer.name)  # Target to focus on

onready var _visibility = $Sprite

func _ready():
	# Get all the possible moves by getting all the possible Keys 
	mKeys = attackMoves.keys()
	countDown = maxTimeTillChoice
	
	if(get_node(name + " Input Handler")):
		get_node(name + " Input Handler").queue_free()
	

func _process(delta):
	countDown -= delta
	if(!_isAttacking && countDown < 0):
		_choose_action()

	_face_player()  # Make sure the AI always faces the player

	# Start moving
	if(startMoving && time > 0 && !isCrouching):
		_move_AI()
		time -= delta
	else:
		startMoving = false
		time = maxMoveTime

func _choose_action():
	var percentagePerStep = float(100) / float(maxDistance) # Get the percentage increase with each step
#	print("Percentage Per Step = ", (float(percentagePerStep)), "p/s")
	
	var chance = percentagePerStep * (abs(player.position.x - position.x)) # Calculate the actual chance that the AI has of its current distance from the player 
	chance = 100-clamp(chance, 10, 90) # Invert the scale so that, the closer the AI gets to the player the higher the outcome 
#	print("chance = ", chance, "%")
	
	if(_return_value() <= chance): # Check if the return value between 0 to 100 is good enough for an attack  
#		print(name, " has picked to attack")
		var randomAttack = RandomNumberGenerator.new()
		randomAttack.randomize()
		var attackValue = randomAttack.randi_range(0, mKeys.size() - 1)  # Pick from all possible moves what kind of attack is needed
		animPlayer.play(attackMoves[mKeys[randomAttack.randi_range(0, mKeys.size() - 1)]])
	else:
#		print(name, " has picked to move")
		startMoving = true
		time = maxMoveTime
		animPlayer.play("Idle Animation")
		_SetCrouchedState(false)
		
		# IF THE AI IS CROUCHING IT CAN'T MOVE 
	countDown = maxTimeTillChoice

# Generate a random value between 0 to 100 and return it
func _return_value():
	var generator = RandomNumberGenerator.new()
	var value
	generator.randomize()
	value = generator.randi_range(0, 100)
	
#	print("-------------------------")
#	print("Value = ", value, "%")
#	print("-------------------------")
	
	return value

func _face_player():
	var distanceToPlayer =  player.position.x - position.x # The place AI needs to go to - the place where it is = distance between the spots
	
	if(distanceToPlayer > offsetTillFlip):    # AI comes from the left
		moveDir = 1
		scale.x = scale.y * moveDir
	elif(distanceToPlayer < -offsetTillFlip):  # AI comes from the right
		moveDir = -1
		scale.x = scale.y * moveDir
	else:
		moveDir = 0

# A simple function that allows movement
func _move_AI():
	velocity = Vector2()
	velocity.x += moveDir * AIMovementSpeed
	velocity = move_and_slide(velocity)

func _SetCrouchedState(var input):
	isCrouching = input

func _SetAttackingState(var input):
	_isAttacking = input
	z_index = 1
	player.z_index = 0
