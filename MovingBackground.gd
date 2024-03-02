extends ParallaxBackground

@export var scroll_speed: Vector2 = Vector2.ZERO;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	scroll_offset += scroll_speed * delta
