extends Area2D

onready var gameRef = get_parent().get_parent()

func Player_Hit_AI(body):
	if(body.name == gameRef.givenOpponent.name):
		gameRef.HUDManager.UpdateHealth(false, 15)
		print_debug(name)


func AI_Hit_Player(body):
	if(body.name == gameRef.givenPlayer.name):
		gameRef.HUDManager.UpdateHealth(true, 15)
		print_debug(name)
