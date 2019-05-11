extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const BLOCK = preload("res://BasicBlock.tscn")
const BLOCK_SIZE = 8

var player
# Called when the node enters the scene tree for the first time.
func _ready():
	var amount_of_blocks = int(round(rand_range(4, 9)))
	for i in range(amount_of_blocks):
		var block = BLOCK.instance()
		block.position.y = 0
		block.position.x = i * BLOCK_SIZE * block.scale.x   
		self.add_child(block)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player.position.y - 210 > self.position.y:
		self.queue_free()
