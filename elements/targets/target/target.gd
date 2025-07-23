extends CharacterBody2D

var speed := PI
# 2 PI is full circle -> 1 PI is half circle

func _physics_process(delta: float):
	rotation += speed*delta

