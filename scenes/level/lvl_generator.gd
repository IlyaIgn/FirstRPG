extends Node2D

@export var tilemap: TileMapLayer
@export var player: CharacterBody2D
@export var lootbox: PackedScene
@export var tilemap_shadow: TileMapLayer
#@export var noise: FastNoiseLite

var FLOOR_TILE = Vector2i(2,4)
const WALL_TILE = Vector2i(1,1)
const SHADOW_ON_TILE = Vector2i(22,16)

var main_rooms : Array[Rect2]
const DUNGEON_WIDTH = 80
const DUNGEON_HEIGHT = 80
enum TileType { EMPTY, FLOOR, WALL }
var dungeon_grid = []

func _ready() -> void:
	create_dungeon()
	pass

func get_lvl_size() -> Vector2i:
	return Vector2i(DUNGEON_WIDTH, DUNGEON_HEIGHT)
	
func get_new_mob_pos():
	var player_room : Rect2
	for room in main_rooms:
		if room.has_point(player.position):
			player_room = room
	
	var room_num = randi_range(0, main_rooms.size() - 1 )
	while main_rooms[room_num] == player_room:
		room_num = randi_range(0, main_rooms.size() - 1)
	return main_rooms[room_num].get_center() * 16
		
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
		var w = randi_range(8, 16)
		var h = randi_range(8, 16)
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
			
			if rooms.size() > 1:
				var prev = rooms[rooms.size() - 2].get_center()
				var curr = room.get_center()
				carve_corridor(prev, curr)
 
		tries += 1
 
	return rooms

func generate_lootbox():
	for room in main_rooms:
		var spawn_x = randi_range(room.position.x, room.position.x + room.size.x)
		var spawn_y = randi_range(room.position.y, room.position.y + room.size.y)
		
		var rotate_val = 0
		
		if spawn_x == room.position.x:
			spawn_x += 1
			rotate_val = -90
		elif spawn_x == room.position.x + room.size.x:
			spawn_x -= 1
			rotate_val = 90
			
		if spawn_y == room.position.y:
			spawn_y += 0.5
		elif spawn_y == room.position.y + room.size.y:
			spawn_y -= 0.5
			rotate_val = 180
		
		var lootbox_point = Vector2(spawn_x, spawn_y)
		create_closet(lootbox_point, rotate_val)
	pass
	
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
	tilemap.clear()
	for y in range(DUNGEON_HEIGHT):
		for x in range(DUNGEON_WIDTH):
			var tile = dungeon_grid[y][x]
			match tile:
				TileType.FLOOR: 
					FLOOR_TILE.x = randf_range(1,3)
					tilemap.set_cell(Vector2i(x, y), 0, FLOOR_TILE)
				TileType.WALL: 
					tilemap.set_cell(Vector2i(x, y), 0, WALL_TILE)
			tilemap_shadow.set_cell(Vector2i(x, y), 1, SHADOW_ON_TILE)
 
func create_closet(lootbox_pos : Vector2, rotate_val : int = 0):
	var lootbox_instance = lootbox.instantiate() as Node2D
	get_parent().add_child(lootbox_instance)
	lootbox_instance.global_position = lootbox_pos * 16
	lootbox_instance.rotation = rotate_val
	
func place_player():
	player.position = main_rooms.pick_random().get_center() * 16
		
func create_dungeon():
	main_rooms = generate_dungeon()
	place_player()
	add_walls()
	render_dungeon()
