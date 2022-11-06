extends Sprite

# Object Array
var characters = []          # Array to store all the characters the player can select

# Integer
var currentSelected = 0      # Spot of the cursor within the characters[]
var currentColumnSpot = 0    # Spot of the cursor based on the column
var currentRowSpot = 0       # Spot of the cursor based on the row

# Exports 
export (Texture) var player1Text    # Cursor Texture for when Player 1 is making a decision    
export (Texture) var player2Text    # Cursor Texture for when Player 2 is making a decision
export (int) var amountOfRows = 2      # The total amount of rows the character select is able to show 
export (Vector2) var portraitOffset   # The distance between the portraits

# Objects
onready var gridContainer = get_parent().get_node("GridContainer")   # Get the Gridcontainer

func _ready():
# Get all of the characters stored within the group "Characters" and place them in the Array characters
	for nameOfCharacter in get_tree().get_nodes_in_group("Characters"):
		characters.append(nameOfCharacter)
#	print(characters)
	texture = player1Text

# This whole _process(delta) function is used to allow scrolling through all the characters
func _process(delta):
	if(Input.is_action_just_pressed("InputRight")):
		currentSelected += 1
		currentColumnSpot += 1
		# If the cursor goes past the total amount of columns reset to the first item in the column and go 1 row down
		if(currentColumnSpot > gridContainer.columns - 1 && currentSelected < characters.size() - 1):
			position.x -= (currentColumnSpot - 1) * portraitOffset.x
			position.y += portraitOffset.y
			
			currentColumnSpot = 0
			currentRowSpot += 1
		# If the cursor goes past the total amount of columns and amount of characters, reset to the first item in the whole roster 
		elif(currentColumnSpot > gridContainer.columns - 1 && currentSelected > characters.size() - 1):
			position.x -= (currentColumnSpot - 1) * portraitOffset.x
			position.y -= currentRowSpot * portraitOffset.y
			
			currentColumnSpot = 0
			currentRowSpot = 0
			currentSelected = 0
		else:
			position.x += portraitOffset.x
	elif(Input.is_action_just_pressed("InputLeft")):
		currentSelected -= 1
		currentColumnSpot -= 1
		# If the cursor goes past the 0 amount on a column position reset to the first item in the column and go 1 row up
		if(currentColumnSpot < 0 && currentSelected > 0):
			position.x += (gridContainer.columns - 1) * portraitOffset.x
			position.y -= (amountOfRows - 1) * portraitOffset.y
			
			currentColumnSpot = gridContainer.columns - 1
			currentRowSpot -= 1
		# If the cursor goes past the 0 amount on a column position and 0 amount of characters, reset to the last item in the whole roster 
		elif (currentColumnSpot < 0 && currentSelected < 0):
			position.x += (gridContainer.columns - 1) * portraitOffset.x
			position.y += (amountOfRows - 1) * portraitOffset.y
			
			currentColumnSpot = gridContainer.columns - 1
			currentRowSpot = amountOfRows - 1
			currentSelected = characters.size() - 1
		else:
			position.x -= portraitOffset.x

# If a selection is made send it to the Signleton CharacterSelectionManager.gd to store that value
	if(Input.is_action_just_pressed("ui_accept")):
#		print(characters[currentSelected].name)
#		CharacterSelectionManager.player1Character = characters[currentSelected].name
		if(CharacterSelectionManager.player == null):
			CharacterSelectionManager.player = CharacterSelectionManager.selectableCharacters[characters[currentSelected].name]
			CharacterSelectionManager.player1Selected = currentSelected
			texture = player2Text
		else:
			CharacterSelectionManager.opponent = CharacterSelectionManager.selectableCharacters[characters[currentSelected].name]
			CharacterSelectionManager.player2Selected = currentSelected
			get_tree().change_scene("res://Scenes/Game.tscn")
