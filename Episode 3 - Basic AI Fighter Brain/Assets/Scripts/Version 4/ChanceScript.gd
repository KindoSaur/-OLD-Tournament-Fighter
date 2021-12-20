extends KinematicBody2D

var maxTimeTillChoice = 3
var countDown = maxTimeTillChoice

onready var playerPos = get_parent().get_node("Ryu")

var maxDistance = 300
var minDistance = 75

func _ready():
	countDown = maxTimeTillChoice

func _process(delta):
	countDown -= delta
	if(countDown < 0):
		print("-------------------------")
		print("Value = ", ReturnChance(), "%")
		print("-------------------------")
		
		var percentagePerStep = float(100) / float(maxDistance)
		var chance = abs(percentagePerStep * (playerPos.position.x - position.x))
		
		print("Percentage Per Step = ", (float(percentagePerStep)), "p/s")
		print("chance = ", chance, "%")
		
		if(ReturnChance() <= 30):
			print(name, " has picked to attack")
		else:
			print(name, " has picked to move")
		
		countDown = maxTimeTillChoice

func ReturnChance():
	
	
	
	
	var value = RandomNumberGenerator.new()
	value.randomize()
	return value.randi_range(0, 100)

#func ReturnChance():
#	var distanceToPlayer = abs(playerPos.position.x - position.x)
#	print("Distance To Player = ", (float(distanceToPlayer)))
#
#	var percentageDistance = maxPercentage - minPercentage
#	print("Percentage Distance = ", (float(percentageDistance)))
#
#	var distance = abs(maxDistance - playerPos.position.x)
#	print("Distance = ", (float(distance)))
#
#	percentagePerStep = abs(percentageDistance / distance)
#	print("Percentage Per Step = ", (float(percentagePerStep)))
#
#	var chance = minPercentage + (percentagePerStep * distanceToPlayer)
#
#	return chance
