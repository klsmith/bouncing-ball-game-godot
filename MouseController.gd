extends Node2D

@export var ball_scene: PackedScene;

@onready var viewport = get_viewport()

var dragging := false
var drag_start: Vector2
var drag_end: Vector2
var _cursor_size: int = 1
var cursor_size: int:
	get: return _cursor_size
	set(value): _cursor_size = clampi(value,1,10)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("player_create_ball"):
		drag_start = viewport.get_mouse_position()
		dragging = true
	elif event.is_action_released("player_create_ball"):
		drag_end = viewport.get_mouse_position()
		dragging = false
		create_ball()
	elif event.is_action("player_cursor_size_up"):
		cursor_size += 1
	elif event.is_action("player_cursor_size_down"):
		cursor_size -= 1

func create_ball():
	var ball = ball_scene.instantiate()
	ball.position = drag_start
	ball.size = cursor_size
	ball.direction = drag_start.angle_to_point(drag_end)
	get_parent().add_child(ball)

func _process(delta):
	queue_redraw()
	if dragging: 
		drag_end = viewport.get_mouse_position()

func _draw():
	var cursor_position = viewport.get_mouse_position();
	if dragging:
		cursor_position = drag_start
		draw_line(drag_start, drag_end, Color.WHITE)
	var s = cursor_size * GameStats.ball_base_size * GameStats.ball_scale_factor
	draw_arc(cursor_position, s, 0, TAU + 1, 64, Color.WHITE)
