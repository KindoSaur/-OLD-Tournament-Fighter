extends Control

onready var player1HealthBar = get_node("KO-bar Holder/Player1Health") # Healthbar Player 1
onready var player2HealthBar = get_node("KO-bar Holder/Player2Health") # Healthbar Player 2

var oneSeconds = 9  # second number in the timer represented as 1x this amount
var tenSeconds = 9 # first number in the timer represented as 10x this amount
var resetOnes = true # allow the reset of the units to happen if this lowers than 0

onready var timer = get_node("Time Holder/Timer")
onready var oneSprite = get_node("Time Holder/1s")
onready var tenSprite = get_node("Time Holder/10s")

export (Array) var timeSprites  # An Array filled with images of the numbers 0 to 9

export (Array) var namesP1 # Images of the character name P1
export (Array) var namesP2 # Images of the character name P2

onready var playerName1 = get_node("Names/Player Name 1")
onready var playerName2 = get_node("Names/Player Name 2")

func UpdateHealth(var fromPlayerHealth, var damage):
	if(fromPlayerHealth):
		player1HealthBar.value -= damage
		if(player1HealthBar.value <= 0):
			GameOver()
	else:
		player2HealthBar.value -= damage
		if(player2HealthBar.value <= 0):
			GameOver()

func GameOver():
	pass


func _on_Timer_timeout():
	oneSeconds -= 1
	
	if(oneSeconds < 0):
		if(resetOnes):
			oneSeconds = 9
			tenSeconds -= 1
		else:
			oneSeconds = 0
			timer.stop()
			GameOver()
		
		if(tenSeconds == 0):
			tenSeconds = 0
			resetOnes = false

	oneSprite.texture = timeSprites[oneSeconds]
	tenSprite.texture = timeSprites[tenSeconds]
	
	timer.wait_time = 1

func UpdateNameElements(var player1ID, var player2ID):
	playerName1.texture = namesP1[player1ID]
	playerName2.texture = namesP2[player2ID]
