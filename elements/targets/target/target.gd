extends CharacterBody2D
class_name Target

const KNIFE_POSITION = Vector2(0, 180)

# 2 PI is full circle -> 1 PI is half circle
var speed := PI

#container to hold knifes
@onready var items_container := $ItemsContainer

func _physics_process(delta: float):
	rotation += speed*delta

# function to rotate knifes. object_rotation is angle in radians
func add_object_with_pivot(object: Node2D, object_rotation: float):
	var pivot := Node2D.new()
	pivot.rotation = object_rotation
	pivot.add_child(object)
	items_container.add_child(pivot)
