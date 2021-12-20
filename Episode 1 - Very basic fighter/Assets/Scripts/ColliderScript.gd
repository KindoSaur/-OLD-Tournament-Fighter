extends Node2D

var p1FightColl = []
var disableColl = true

func _ready():
	_Handle_All_Collider_Disabling(disableColl)


func _process(delta):
	if(Input.is_action_just_pressed("ui_left")):
		disableColl = !disableColl
		_Handle_All_Collider_Disabling(disableColl)
	
	if(Input.is_action_just_pressed("ui_down")):
		disableColl = !disableColl
		_Handle_Specific_Collider_Disabling(disableColl, 0)


func _on_Left_Hand_body_entered(body):
	if(body.name == "E Honda"):
		print("-----")
		print("E Honda hit with Left Hand")
		print("-----")


func _on_Right_Hand_body_entered(body):
	pass # Replace with function body.


func _on_Left_Foot_body_entered(body):
	pass # Replace with function body.


func _on_Right_Foot_body_entered(body):
	if(body.name == "E Honda"):
		print("-----")
		print("E Honda hit with Right Foot")
		print("-----")

func _Handle_All_Collider_Disabling(var isDisabled):
	for colliders in get_tree().get_nodes_in_group("P1 Hand Feet Coll"):
		var h = 0
		
		p1FightColl.insert(h, colliders)
		p1FightColl[h].set_disabled(isDisabled)
		
		print(p1FightColl[h].name)
		
		if(p1FightColl[h].is_disabled()):
			print(p1FightColl[h].name + " is disabled")
		elif(!p1FightColl[h].is_disabled()):
			print(p1FightColl[h].name + " is NOT disabled")
		
		print("")
		h += 1

func _Handle_Specific_Collider_Disabling(var isDisabled, var pickedColl):
	p1FightColl[pickedColl].set_disabled(isDisabled)
	
	if(!p1FightColl[pickedColl].is_disabled()):
		print(p1FightColl[pickedColl].name + " has been enabled")
	elif(p1FightColl[pickedColl].is_disabled()):
		print(p1FightColl[pickedColl].name + " has been DIS-abled")
