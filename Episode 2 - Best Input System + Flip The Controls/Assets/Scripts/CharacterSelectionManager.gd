extends Node

var player 
var player1Selected
var playerScript = preload("res://Scripts/InputHandler.gd")

var opponent
var player2Selected
var aiScript = preload("res://Scripts/AI Script/AIScript.gd")

var selectableCharacters = {
	"Ryu" : preload("res://Prefabs/Fighters/Ryu.tscn"),
	"E Honda" : preload("res://Prefabs/Fighters/E Honda.tscn"),
	"Blanka" : preload("res://Prefabs/Fighters/Blanka.tscn"),
	"Ken" : preload("res://Prefabs/Fighters/Ken.tscn"),
	"Chun Li" : preload("res://Prefabs/Fighters/Chun Li.tscn"),
	"Zangief" : preload("res://Prefabs/Fighters/Zangief.tscn")
}
