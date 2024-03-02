extends StaticBody2D

@onready var top := %TopBorder
@onready var left := %LeftBorder
@onready var right := %RightBorder
@onready var bottom := %BottomBorder
@onready var background_sprite := %BackgroundSprite as Sprite2D
@onready var background_layer := %BackgroundLayer as ParallaxLayer
@onready var midground_sprite := %MidgroundSprite as Sprite2D
@onready var midground_layer := %MidgroundLayer as ParallaxLayer
@onready var foreground_sprite := %ForegroundSprite as Sprite2D
@onready var foreground_layer := %ForegroundLayer as ParallaxLayer
@onready var viewport := get_viewport()

var texture_size: Vector2;

# Called when the node enters the scene tree for the first time.
func _ready():
	viewport.size_changed.connect(on_viewport_size_changed)
	# cheating here because all layers textures are same size
	texture_size = foreground_sprite.texture.get_size()
	recalculate_borders()

func on_viewport_size_changed():
	recalculate_borders()

func recalculate_borders():
	var view = viewport.get_visible_rect()
	var pm = calculate_parralax_mirror(view)
	background_sprite.set_region_rect(Rect2(view.position, pm))
	background_layer.motion_mirroring = pm
	midground_sprite.set_region_rect(Rect2(view.position, pm))
	midground_layer.motion_mirroring = pm
	foreground_sprite.set_region_rect(Rect2(view.position, pm))
	foreground_layer.motion_mirroring = pm
	top.position.x = view.position.x + (view.size.x / 2)
	top.position.y = view.position.y
	left.position.x = view.position.x
	left.position.y = view.position.y + (view.size.y / 2)
	right.position.x = view.position.x + view.size.x
	right.position.y = view.position.y + (view.size.y / 2)
	bottom.position.x = view.position.x + (view.size.x / 2)
	bottom.position.y = view.position.y + view.size.y
 
func calculate_parralax_mirror(view: Rect2) -> Vector2:
	return Vector2(
		ceilf((view.size.x) / texture_size.x) * texture_size.x,
		ceilf((view.size.y) / texture_size.y) * texture_size.y
	)
