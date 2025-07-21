extends Node2D

var knife_scene := preload("res://elements/knife/knife.tscn")

@onready var knife := $Knife
@onready var timer := $Timer

func create_new_knife():
	knife = knife_scene.instantiate()
	add_child(knife)

func _input(event: InputEvent):
	if event is InputEventScreenTouch and event.is_pressed() and timer.time_left <= 0:
		knife.throw()
		timer.start()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	create_new_knife()
