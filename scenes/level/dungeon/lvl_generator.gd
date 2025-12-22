extends Node2D

@export var tilemap_floor: TileMapLayer
@export var tilemap_env: TileMapLayer

@export var player: CharacterBody2D

const rooms_count = 5
var tile_list = []
var main_rooms : Array[Rect2]
const DUNGEON_WIDTH = rooms_count * 10
const DUNGEON_HEIGHT = DUNGEON_WIDTH
enum TileType { EMPTY, FLOOR, WALL, ENTER, EXIT }
var dungeon_grid = []

func _ready() -> void:
	create_dungeon()
	pass

func get_lvl_size() -> Vector2i:
	return Vector2i(DUNGEON_WIDTH, DUNGEON_HEIGHT)
		
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
 
func set_gates():
	dungeon_grid[2][0] = TileType.ENTER
	
	var last_room = main_rooms[main_rooms.size()-1]
	var exit_pos = last_room.position + last_room.size / 2
	exit_pos.x = last_room.position.x + last_room.size.x
	dungeon_grid[exit_pos.y][exit_pos.x] = TileType.EXIT
	pass
	
#func add_walls():
	#for room in main_rooms:
		#for x in range(room.position.x, room.size.x + 1):
			#dungeon_grid[room.position.y][x] = TileType.WALL
	#pass
 
func render_dungeon():
	tile_list.clear()
	tilemap_floor.clear()
	for y in range(DUNGEON_HEIGHT):
		for x in range(DUNGEON_WIDTH):
			if dungeon_grid[y][x] != TileType.EMPTY:
				tile_list.append(Vector2(x,y))
				
	tilemap_floor.set_cells_terrain_connect(tile_list, 0, 0, false)
	
	for y in range(DUNGEON_HEIGHT):
		for x in range(DUNGEON_WIDTH):
			if dungeon_grid[y][x] == TileType.ENTER:
				tilemap_env.set_cell(Vector2(x,y), 5, Vector2(7,3))
				
			if dungeon_grid[y][x] == TileType.EXIT:
				tilemap_env.set_cell(Vector2(x,y), 7, Vector2(8,3))
				
			#if dungeon_grid[y][x] == TileType.WALL:
				#tilemap_env.set_cell(Vector2(x,y), 3, Vector2(27,8))
	
func place_player():
	for y in range(DUNGEON_HEIGHT):
		for x in range(DUNGEON_WIDTH):
			if dungeon_grid[y][x] == TileType.FLOOR:
				player.position = Vector2(20,48)
				return
		
func create_dungeon():
	main_rooms = generate_dungeon()
	#add_walls()
	set_gates()
	render_dungeon()
	place_player()
