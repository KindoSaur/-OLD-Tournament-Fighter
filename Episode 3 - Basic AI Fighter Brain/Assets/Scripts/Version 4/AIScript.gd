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
var gKeys = [] # General Move Keys
var sKeys = [] # Specific Move Keys

#Vector
var velocity = Vector2()  # Current velocity of the AI

#Boolean
var startMoving = false # Check if the AI is allowed to move 
var isCrouching = false # Check if the AI isn't crouching

#Object
onready var animTree = $AnimationTree.get("parameters/playback") # Get the AI animationtree
onready var player = get_parent().get_node("Ryu")  # Target to focus on (currently its Ryu )

#References
var generalMoves = MoveSetManager.nameDictionary["General"] # Possible general moves of the AI
var specificMoves = MoveSetManager.nameDictionary[name] # Specific moveset of the current AI


func _ready():
	# Get all the possible moves by getting all the possible Keys 
	sKeys = specificMoves.keys()
	gKeys = generalMoves.keys()
	
	countDown = maxTimeTillChoice

func _process(delta):
	
	countDown -= delta
	if(countDown < 0):
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
	print("chance = ", chance, "%")
	
	if(_return_value() <= chance): # Check if the return value between 0 to 100 is good enough for an attack  
		print(name, " has picked to attack")
		var randomAttack = RandomNumberGenerator.new()
		randomAttack.randomize()
		var attackValue = randomAttack.randi_range(0, sKeys.size() + gKeys.size() - 1)  # Pick from all possible moves what kind of attack is needed
		
		if(attackValue < sKeys.size()):
			animTree.travel(specificMoves[sKeys[randomAttack.randi_range(0, sKeys.size() - 1)]])
		else:
			animTree.travel(generalMoves[gKeys[randomAttack.randi_range(0, gKeys.size() - 1)]])
	else:
		print(name, " has picked to move")
		startMoving = true
		time = maxMoveTime
		animTree.travel(generalMoves[gKeys[3]])
		_crouch(false)
		
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


func _crouch(var input):
	isCrouching = input
