extends CanvasLayer

@onready var ball_count_label := %BallCountLabel as Label
@onready var control_panel := %ControlPanel as PanelContainer
@onready var control_panel_collapse_button := %ControlPanelCollapseButton as Button

@onready var ball_scale_label := %BallScaleLabel as Label
@onready var ball_scale_slider := %BallScaleSlider as HSlider

@onready var health_factor_label := %HealthFactorLabel as Label
@onready var health_factor_slider := %HealthFactorSlider as HSlider

func _ready():
	GameStats.ball_count_changed.connect(update_ball_count_label)
	GameStats.ball_scale_factor_changed.connect(update_ball_scale_slider)
	GameStats.ball_health_factor_changed.connect(update_health_factor_slider)
	update_ball_scale_slider(GameStats.ball_scale_factor)
	update_health_factor_slider(GameStats.ball_health_factor)
	calculate_collapse_button()

func update_ball_count_label(ball_count: int):
	ball_count_label.text = "Ball Count: " + str(ball_count)

func _on_control_panel_collapse_button_pressed() -> void:
	control_panel.visible = !control_panel.visible
	calculate_collapse_button()

func calculate_collapse_button():
	control_panel_collapse_button.text = "<" if control_panel.visible else ">"

func _on_ball_scale_slider_value_changed(value: float) -> void:
	GameStats.ball_scale_factor = value

func update_ball_scale_slider(value: float):
	ball_scale_label.text = "Scale (%.1f)" % value
	ball_scale_slider.set_value_no_signal(value)

func _on_health_factor_slider_value_changed(value: float) -> void:
	print("SLIDE_CHANGED: " + str(value))
	GameStats.ball_health_factor = value

func update_health_factor_slider(value: float):
	print("STATS_CHANGED: " + str(value))
	health_factor_label.text = "Health Factor (%d)" % value
	health_factor_slider.set_value_no_signal(value)
