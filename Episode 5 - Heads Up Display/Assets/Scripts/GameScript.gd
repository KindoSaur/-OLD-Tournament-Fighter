extends Node2D

onready var givenPlayer = CharacterSelectionManager.player.instance()        # What character player 1 has chosen to be 
onready var givenOpponent = CharacterSelectionManager.opponent.instance()    # What character player 2 has chosen to be

onready var HUDManager = get_node("HUD Elements")

func _ready():
#	print(CharacterSelectionManager.player1Character)
	SpawnChosenCharacters()
	HUDManager.UpdateNameElements(CharacterSelectionManager.player1Selected,CharacterSelectionManager.player2Selected)

# At the start of the game the chosen characters need to be spawned in and also receive an offset to eachother
func SpawnChosenCharacters():
	givenPlayer.position = Vector2(70, 364)
	givenPlayer.set_script(CharacterSelectionManager.playerScript)  # Set the right script on to the player
	
	call_deferred("add_child", givenPlayer)

	givenOpponent.position = Vector2(442, 364)
	givenOpponent.set_script(CharacterSelectionManager.aiScript)    # Set the right script on to the AI (opponent)
	
	call_deferred("add_child", givenOpponent)
