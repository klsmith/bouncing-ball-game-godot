extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	body_shape_entered.connect(on_collision)
	set_axis_velocity(Vector2(-400,-400))


func on_collision(body_rid: RID, 
				  body: Node,
				  body_shape_index: int,
				  local_shape_index: int):
	
	pass
