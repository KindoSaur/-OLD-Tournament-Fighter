extends Node

#All general moves are stored here
var generalMoves = {
	1 : "Straight Punch",
	2 : "Crouched Straight Punch",
	3 : "Crouch Idle",
	4 : "Idle"
}

#All specific character moves are stored here 
var ryuMoves = {
	["S", "D", "L"] : "Hadoken",
#	2 : "Shakunetsu Hadoken",
	["S", "D", "S", "D", "L" ] : "Shoryuken",
#	4 : "Hurricane Kick",
}

var eHondaMoves = {
	["L", "L", "L"] : "Hundred Hand Slap",
	["A", "D", "L"] : "Sumo Headbutt",
#	3 : "Sumo Smash",
}

var blankaMoves = {
	1 : "Electric Thunder",
	2 : "Rolling Attack",
	3 : "Backstep Roll",
	4 : "Vertical Roll",
}

var guileMoves = {
	1 : "Sonic Boom",
	2 : "Flash Kick",
	3 : "Spin Back Knuckle",
}

var kenMoves = {
	["S", "D", "L"] : "Hadoken",
	["S", "D", "S", "D", "L" ] : "Shoryuken",
	3 : "Hurricane Kick",
	4 : "Roundhouse Kick",
}

var chunliMoves = {
	1 : "Roundhouse Kick",
	2 : "Lightning Kick",
	3 : "Tenshokyaku",
	4 : "Spinning Bird Kick",
	5 : "Kikoken",
	6 : "Yousou Kyaku",
}

var zangiefMoves = {
	1 : "Double Lariat",
	2 : "Spinning Piledriver",
	3 : "Banishing Flat",
}

var dhalismMoves = {
	1 : "Yoga Fire",
	2 : "Yoga Flame",
	3 : "Yoga Blast",
	4 : "Yoga Spear",
	5 : "Yoga Mummy",
	6 : "Yoga Teleport",
}

#A special dictionary to store all of the character names and also connect them to their own movement list
var nameDictionary = {
	"Ryu" : ryuMoves,
	"E Honda" : eHondaMoves,
	"Blanka" : blankaMoves,
	"Guile" : guileMoves,
	"Ken" : kenMoves,
	"Chun Li" : chunliMoves,
	"Zangief" : zangiefMoves,
	"Dhalism" : dhalismMoves,
	
	"General" : generalMoves
}

