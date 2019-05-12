extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const BLOCK = preload("res://BasicBlock.tscn")
const BLOCK_SIZE = 8

const MAX_BLOCK_WIDTH = 10
const MAX_BLOCK_HEIGHT = 3
const MAX_BLOCKS = MAX_BLOCK_WIDTH * MAX_BLOCK_HEIGHT

var player


func spawn_random_block(x, y, block_positions):
	# adds the block
	var block = BLOCK.instance()
	block.position.x = x * BLOCK_SIZE * block.scale.x
	block.position.y = y * BLOCK_SIZE * block.scale.y
	self.add_child(block)
	block_positions.append([x, y])
	# spawns random blocks next to it
	for diff in [[-1, 0], [1, 0], [0, -1], [0, 1]]:
		var new_x = x + diff[0]
		var new_y = y + diff[1]
		if !([new_x, new_y] in block_positions):
			# chance for a new block next to it
			var chance = pow(1 - (len(block_positions) / float(MAX_BLOCKS)), 2)
			if rand_range(0, 1) < chance:
				if abs(new_x) <= (MAX_BLOCK_WIDTH - 1) / 2:
					if abs(new_y) <= (MAX_BLOCK_HEIGHT - 1) / 2:
						spawn_random_block(new_x, new_y, block_positions)

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_random_block(0, 0, [])
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player.position.y - 210 > self.position.y:
		self.queue_free()
