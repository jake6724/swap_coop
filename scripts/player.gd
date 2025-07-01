class_name Player
extends CharacterBody2D

signal player_ready

func _ready():
	player_ready.emit()