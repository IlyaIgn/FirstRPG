extends Node2D

@export var tilemap_floor: TileMapLayer
@export var player: CharacterBody2D

const rooms_count = 5
var tile_list = []
var main_rooms : Array[Rect2]
const DUNGEON_WIDTH = rooms_count * 10
const DUNGEON_HEIGHT = DUNGEON_WIDTH
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
 
	var rooms : Array[Rect2]
	var max_attempts = 100
	var tries = 0
 
	while rooms.size() < rooms_count and tries < max_attempts:
		var w = randi_range(4,8) * 2
		var h = randi_range(4,8) * 2
		var x = randi_range(1, DUNGEON_WIDTH - w - 1)
		var y = randi_range(1, DUNGEON_HEIGHT - h - 1)
		
		if rooms.size() == 0:
			w=6; h=6; x=0; y=0
			
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
	
func carve_corridor(from: Vector2, to: Vector2): 
	for x in range(min(from.x, to.x), max(from.x, to.x) + 1):
		var y = from.y
		if is_in_bounds(x, y):
			dungeon_grid[y-1][x] = TileType.FLOOR
			dungeon_grid[y][x] = TileType.FLOOR
			dungeon_grid[y+1][x] = TileType.FLOOR

	for y in range(min(from.y, to.y), max(from.y, to.y) + 1):
		var x = to.x
		if is_in_bounds(x, y):
			dungeon_grid[y][x-1] = TileType.FLOOR
			dungeon_grid[y][x] = TileType.FLOOR
			dungeon_grid[y][x+1] = TileType.FLOOR
 
func is_in_bounds(x: int, y: int) -> bool:
	return x >= 0 and y >= 0 and x < DUNGEON_WIDTH and y < DUNGEON_HEIGHT
 
func add_walls():
	pass
 
func render_dungeon():
	tile_list.clear()
	tilemap_floor.clear()
	for y in range(DUNGEON_HEIGHT):
		for x in range(DUNGEON_WIDTH):
			if dungeon_grid[y][x] == TileType.FLOOR:
				tile_list.append(Vector2(x,y))
	tilemap_floor.set_cells_terrain_connect(tile_list, 0, 0, false)
	
func place_player():
	for y in range(DUNGEON_HEIGHT):
		for x in range(DUNGEON_WIDTH):
			if dungeon_grid[y][x] == TileType.FLOOR:
				player.position = Vector2(180,-25)
				return
		
func create_dungeon():
	main_rooms = generate_dungeon()
	add_walls()
	render_dungeon()
	place_player()
