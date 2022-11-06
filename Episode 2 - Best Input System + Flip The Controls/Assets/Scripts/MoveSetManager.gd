extends Node

var RyuMoves = {
	["U"] : "Standing Light Jab Animation",
	["S","U"] : "Crouch Jab Animation",
	
	["J"] : "Standing Light Kick Animation",
	["S","J"] : "Crouch Light Kick Animation",
	
	["S","D","U"] : "Hadoken",
	["S","D","S","D","U"] : "Shoryuken"
}

var RyuFlippedMoves = {
	["U"] : "Standing Light Jab Animation",
	["S","U"] : "Crouch Jab Animation",
	
	["J"] : "Standing Light Kick Animation",
	["S","J"] : "Crouch Light Kick Animation",
	
	["S","A","U"] : "Hadoken",
	["S","A","S","A","U"] : "Shoryuken"
}

var EHondaMoves = {
	["U"] : "Standing Light Jab Animation",
	["S","U"] : "Crouch Jab Animation",
	
	["J"] : "Standing Light Kick Animation",
	["S","J"] : "Crouch Light Kick Animation",
	
	["A","D","U"] : "Sumo Headbutt",
}

var EHondaFlippedMoves = {
	["U"] : "Standing Light Jab Animation",
	["S","U"] : "Crouch Jab Animation",
	
	["J"] : "Standing Light Kick Animation",
	["S","J"] : "Crouch Light Kick Animation",
	
	["D","A","U"] : "Sumo Headbutt",
}

var BlankaMoves = {
	["P"] : "Idle Animation"
}

var KenMoves = {
	["P"] : "Idle Animation"
}

var ChunLiMoves = {
	["P"] : "Idle Animation"
}

var ZangiefMoves = {
	["P"] : "Idle Animation"
}

var Characters = {
	"Ryu" : RyuMoves,
	"Ryu Flipped" : RyuFlippedMoves,
	
	"E Honda" : EHondaMoves,
	"E Honda Flipped" : EHondaFlippedMoves,
	
	"Blanka" : BlankaMoves,
	"Ken" : KenMoves,
	"Chun Li" : ChunLiMoves,
	"Zangief" : ZangiefMoves
}
