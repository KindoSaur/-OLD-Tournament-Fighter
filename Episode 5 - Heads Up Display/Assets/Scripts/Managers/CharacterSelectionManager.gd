extends Node

var player 
var player1Selected
var playerScript = preload("res://Assets/Scripts/Player Scripts/PlayerMovementScript.gd")

var opponent
var player2Selected
var aiScript = preload("res://Assets/Scripts/AI Scripts/AIScript.gd")

var selectableCharacters = {
	"Ryu" : preload("res://Assets/Scenes/Characters/Ryu.tscn"),
	"E Honda" : preload("res://Assets/Scenes/Characters/E Honda.tscn"),
	"Blanka" : preload("res://Assets/Scenes/Characters/Blanka.tscn"),
	"Ken" : preload("res://Assets/Scenes/Characters/Ken.tscn"),
	"Chun Li" : preload("res://Assets/Scenes/Characters/Chun Li.tscn"),
	"Zangief" : preload("res://Assets/Scenes/Characters/Zangief.tscn")
}
