extends Node2D

@export var tilemap_floor: TileMapLayer
@export var player: CharacterBody2D

var FLOOR_TILE = Vector2i(2,4)
const WALL_TILE = Vector2i(1,1)
const GATE_TILE = Vector2i(6,9)
const SHADOW_ON_TILE = Vector2i(22,16)

var main_rooms : Array[Rect2]
const DUNGEON_WIDTH = 80
const DUNGEON_HEIGHT = 80
enum TileType { EMPTY, FLOOR, WALL, GATE }
var dungeon_grid = []

func _ready() -> void:
	create_dungeon()
	pass

func get_lvl_size() -> Vector2i:
	return Vector2i(DUNGEON_WIDTH, DUNGEON_HEIGHT)
	
func get_new_mob_pos():
	var room_num = randf_range(0, main_rooms.size()-1)
	var spawn_pos = Vector2(main_rooms[room_num].position.x+1,main_rooms[room_num].position.y+1) * 16
	return spawn_pos + Vector2(8,8)
		
func generate_dungeon():
	dungeon_grid = []
	for y in DUNGEON_HEIGHT:
		dungeon_grid.append( [] )
		for x in DUNGEON_WIDTH:
			dungeon_grid[y].append( TileType.EMPTY )
 
	var rooms : Array[Rect2] = []
	var max_attempts = 100
	var tries = 0
 
	while rooms.size() < 10 and tries < max_attempts:
		#var w = randi_range(16, 32)
		#var h = randi_range(16, 32)
		var w = randi_range(8,16)
		var h = randi_range(8,16)
		var x = randi_range(1, DUNGEON_WIDTH - w - 1)
		var y = randi_range(1, DUNGEON_HEIGHT - h - 1)
		var room = Rect2(x, y, w, h)
 
		var overlaps = false
		for other in rooms:
			if room.grow(1).intersects(other):
				overlaps = true
				break
 
		if !overlaps:
			rooms.append(room)
			for iy in range(y, y + h):
				for ix in range(x, x + w):
					dungeon_grid[iy][ix] = TileType.FLOOR
			dungeon_grid[y+1][x+1] = TileType.GATE
			
			if rooms.size() > 1:
				var prev = rooms[rooms.size() - 2].get_center()
				var curr = room.get_center()
				carve_corridor(prev, curr)
 
		tries += 1
 
	return rooms
	
func carve_corridor(from: Vector2, to: Vector2, width: int = 2):
	var min_width = -width / 2
	var max_width = width / 2
 
	if randf() < 0.5:
		for x in range(min(from.x, to.x), max(from.x, to.x) + 1):
			for offset in range(min_width, max_width + 1):
				var y = from.y + offset
				if is_in_bounds(x, y):
					dungeon_grid[y][x] = TileType.FLOOR
 
		for y in range(min(from.y, to.y), max(from.y, to.y) + 1):
			for offset in range(min_width, max_width + 1):
				var x = to.x + offset
				if is_in_bounds(x, y):
					dungeon_grid[y][x] = TileType.FLOOR
	else:
		for y in range(min(from.y, to.y), max(from.y, to.y) + 1):
			for offset in range(min_width, max_width + 1):
				var x = from.x + offset
				if is_in_bounds(x, y):
					dungeon_grid[y][x] = TileType.FLOOR
 
		for x in range(min(from.x, to.x), max(from.x, to.x) + 1):
			for offset in range(min_width, max_width + 1):
				var y = to.y + offset
				if is_in_bounds(x, y):
					dungeon_grid[y][x] = TileType.FLOOR
 
func is_in_bounds(x: int, y: int) -> bool:
	return x >= 0 and y >= 0 and x < DUNGEON_WIDTH and y < DUNGEON_HEIGHT
 
func add_walls():
	for y in range(DUNGEON_HEIGHT):
		for x in range(DUNGEON_WIDTH):
			if dungeon_grid[y][x] == TileType.FLOOR:
				for dy in range(-1, 2):
					for dx in range(-1, 2):
						var nx = x + dx
						var ny = y + dy
						if nx >= 0 and ny >= 0 and nx < DUNGEON_WIDTH and ny < DUNGEON_HEIGHT:
							if dungeon_grid[ny][nx] == TileType.EMPTY:
								dungeon_grid[ny][nx] = TileType.WALL
 
func render_dungeon():
	tilemap_floor.clear()
	for y in range(DUNGEON_HEIGHT):
		for x in range(DUNGEON_WIDTH):
			var tile = dungeon_grid[y][x]
			match tile:
				TileType.FLOOR: 
					FLOOR_TILE.x = randf_range(1,3)
					tilemap_floor.set_cell(Vector2i(x, y), 0, FLOOR_TILE)
				TileType.WALL: 
					tilemap_floor.set_cell(Vector2i(x, y), 0, WALL_TILE)
				TileType.GATE: 
					tilemap_floor.set_cell(Vector2i(x, y), 0, GATE_TILE)
	
func place_player():
	var room_center_pos =  main_rooms.pick_random().get_center() * 16
	player.position = room_center_pos
		
func create_dungeon():
	main_rooms = generate_dungeon()
	add_walls()
	render_dungeon()
	place_player()
