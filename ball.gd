extends RigidBody2D

class_name Ball

var _health: int = 10
var health: int:
	get: return _health
	set(value):
		_health = value
		update_health_color()
		health_label.text = str(_health)
		if (health <= 0):
			split()

var size: int = 1
var direction: float = 0

const healthy_color = Color.LIME
const unhealthy_color = Color.RED

const MAX_SPEED: int = 800

@export var debug_font: Font

@onready var mesh := $OutlineMesh as MeshInstance2D
@onready var rng := RandomNumberGenerator.new()
@onready var collision := $CollisionShape2D as CollisionShape2D
@onready var scene := load(scene_file_path) as PackedScene
@onready var health_label := %HealthLabel as Label

func _ready():
	# connect to signals first
	GameStats.ball_scale_factor_changed.connect(update_scale)
	
	# initialize
	mass = size
	var sphere = (mesh.mesh as SphereMesh)
	sphere.radius = GameStats.ball_base_size
	sphere.height = GameStats.ball_base_size * 2
	(collision.shape as CircleShape2D).radius = GameStats.ball_base_size
	update_scale(GameStats.ball_scale_factor)
	health = calculate_max_health()
	update_health_color()
	body_shape_entered.connect(on_collision)
	set_axis_velocity((
		Vector2.from_angle(direction) * rng.randf_range(1, MAX_SPEED)
	).limit_length(MAX_SPEED))
	GameStats.ball_count += 1

func update_scale(scale_factor: float):
	var s = size * scale_factor
	mesh.scale = Vector2(s, s)
	collision.scale = Vector2(s, s)

func on_collision(body_rid: RID, 
				  body: Node,
				  body_shape_index: int,
				  local_shape_index: int):
	if body is Ball:
		var ball = body as Ball
		health -= ball.size * 2
	else:
		health -= 1

func split():
	if size > 1:
		var ball1 = scene.instantiate() as Ball
		var ball2 = scene.instantiate() as Ball
		ball1.size = max(size - 2, 1)
		ball1.position = position
		ball1.direction = linear_velocity.angle()
		ball2.size = max(size - 2, 1)
		ball2.position = position
		ball2.direction = linear_velocity.angle()
		get_parent().add_child(ball1)
		get_parent().add_child(ball2)
	GameStats.ball_count -= 1
	queue_free()

func calculate_max_health() -> float:
	return size * GameStats.ball_health_factor

func update_health_color() -> void:
	var c = unhealthy_color.lerp(healthy_color,health / calculate_max_health())
	mesh.modulate = Color.from_hsv(c.h, 1, 1, c.a)
