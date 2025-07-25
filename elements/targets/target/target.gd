extends CharacterBody2D
class_name Target

const GENERATION_LIMIT := 100
const KNIFE_POSITION = Vector2(0, 180)
const APPLE_POSITION = Vector2(0, 176)
const OBJECT_MARGIN := 0.96 # size of an apple in radians

var knife_scene : PackedScene = load("res://elements/knife/knife.tscn")
var apple_scene : PackedScene = load("res://elements/apple/apple.tscn")

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

func add_default_items(knives: int, apples: int):
	var occupied_rotations := []
	for i in range(apples):
		var pivot_rotation = get_free_random_rotation(occupied_rotations)
		if pivot_rotation == null:
			return
		occupied_rotations.append(pivot_rotation)			
		var apple = apple_scene.instantiate()
		apple.position = APPLE_POSITION
		add_object_with_pivot(apple, pivot_rotation)
	
	for i in range(knives):
		var pivot_rotation = get_free_random_rotation(occupied_rotations)
		if pivot_rotation == null:
			return
		occupied_rotations.append(pivot_rotation)			
		var knife = knife_scene.instantiate()
		knife.position = KNIFE_POSITION
		add_object_with_pivot(knife, pivot_rotation)
			
func get_free_random_rotation(occupied_rotation : Array, generation_attempts = 0):
	if generation_attempts >= GENERATION_LIMIT:
		return null
		
	var random_rotation = Globals.rng.randf_range(OBJECT_MARGIN / 2, PI*2 - (OBJECT_MARGIN / 2))

	for occupied in occupied_rotation:
		if random_rotation <= occupied + OBJECT_MARGIN / 2.0 and random_rotation >= occupied - OBJECT_MARGIN / 2.0:
			return get_free_random_rotation(occupied_rotation, generation_attempts + 1)
	
	return random_rotation
