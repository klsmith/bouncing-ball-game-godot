extends Node

# Ball Count
signal ball_count_changed(new_value: int)
var _ball_count: int = 0
var ball_count: int:
	get: return _ball_count
	set(value):
		_ball_count = value
		ball_count_changed.emit(_ball_count)


# Ball Scale Factor
signal ball_scale_factor_changed(new_value: float)
var _ball_scale_factor: float = 1
var ball_scale_factor: float:
	get: return _ball_scale_factor
	set(value):
		_ball_scale_factor = value
		ball_scale_factor_changed.emit(_ball_scale_factor)

# Ball Base Size
const ball_base_size: int = 10

# Ball Health Factor
signal ball_health_factor_changed(new_value: float)
var _ball_health_factor: int = 10
var ball_health_factor: int:
	get: return _ball_health_factor
	set(value): 
		_ball_health_factor = value
		ball_health_factor_changed.emit(_ball_health_factor)
