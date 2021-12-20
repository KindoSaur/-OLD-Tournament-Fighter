extends KinematicBody2D

onready var animatedSprite = $AnimatedSprite

var isInCombo = false

var timeTillNextInput = 0.5
var time = 0

var currentAttack = 0
var previousAttack = 0

onready var ColliderScript = $Colliders

func _ready():
	time = timeTillNextInput


func _process(delta):
	if(Input.is_action_just_pressed("ui_punch")):
		if(currentAttack == 0):
			_Reset_Previous_Attack(previousAttack)
			previousAttack = 3
			
			_Set_Attack_Position(3, Vector2(25, 0))
			animatedSprite.play("Straight Punch")

		elif(currentAttack == 1):
			_Reset_Previous_Attack(previousAttack)
			previousAttack = 3
			
			_Set_Attack_Position(3, Vector2(5, -27))
			animatedSprite.play("Upper Cut")

		elif(currentAttack == 2):
			_Reset_Previous_Attack(previousAttack)
			previousAttack = 0
			
			_Set_Attack_Position(0, Vector2(75, -13))
			animatedSprite.play("Low Kick")

		isInCombo = true
		currentAttack += 1
		_Reset_Attack_Timer()

	if(isInCombo):
		time -= delta
		
		if(time < 0):
			time = timeTillNextInput
			isInCombo = false
			currentAttack = 0
			_Reset_Previous_Attack(previousAttack)
			
			animatedSprite.play("Idle")

func _Reset_Attack_Timer():
	if(currentAttack < 4):
		time = timeTillNextInput

func _Set_Attack_Position(var currentAttackID, var newPos):
	ColliderScript.p1FightColl[currentAttackID].position += newPos
	ColliderScript._Handle_Specific_Collider_Disabling(false, currentAttackID)

func _Reset_Previous_Attack(var previousAttackID):
	ColliderScript.p1FightColl[previousAttackID].position = Vector2(0,0)
	ColliderScript._Handle_Specific_Collider_Disabling(true, previousAttackID)

