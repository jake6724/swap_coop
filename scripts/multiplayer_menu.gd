class_name MultiplayerMenu
extends Control

# Child references
@onready var host_button: Button = $VBoxContainer/HostButton
@onready var join_button: Button = $VBoxContainer/JoinButton
@onready var ip_line_edit: LineEdit = $VBoxContainer/IPLineEdit

signal host_pressed
signal join_pressed
signal ip_submitted

func _ready():
	# Connect to signals
	host_button.pressed.connect(on_host_pressed)
	join_button.pressed.connect(on_join_pressed)
	ip_line_edit.text_submitted.connect(on_ip_submitted)

func on_host_pressed():
	host_pressed.emit()

func on_join_pressed():
	join_pressed.emit()

func on_ip_submitted(new_text):
	ip_submitted.emit(new_text)