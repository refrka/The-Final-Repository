extends Control



signal notice_ended

var animation_playing: bool = false
var timer_active: bool = false


func _ready() -> void:
	Signals.GAME_paused.connect(_pause)
	Signals.GAME_unpaused.connect(_unpause)
	%Timer.one_shot = true
	%Timer.timeout.connect(_hide)

	%NoticePanel.mouse_entered.connect(_hover.bind(true))
	%NoticePanel.mouse_exited.connect(_hover.bind(false))
	%NoticePanel.gui_input.connect(_notice_input)
	%AnimationPlayer.animation_finished.connect(_animation_finished)



func setup(message: String) -> void:
	%NoticeMessage.text = message



func start() -> void:
	_show()



func _start_timer() -> void:
	%Timer.start(2.5)
	timer_active = true


func _stop_timer() -> void:
	%Timer.stop()
	timer_active = false


func _show() -> void:
	%AnimationPlayer.play("show")
	animation_playing = true


func _hide() -> void:
	%AnimationPlayer.play("hide")


func _end() -> void:
	notice_ended.emit()



func _pause() -> void:
	if timer_active:
		%Timer.paused = true
	if animation_playing:
		%AnimationPlayer.pause()



func _unpause() -> void:
	if timer_active:
		%Timer.paused = false
	if animation_playing:
		%AnimationPlayer.play()



func _hover(state: bool) -> void:
	if state == true:
		_stop_timer()
	else:
		_start_timer()



func _notice_input(input: InputEvent) -> void:
	if input.is_action_pressed("select") or input.is_action_pressed("right_click"):
		%Timer.stop()
		%Timer.timeout.emit()



func _animation_finished(_name: String) -> void:
	animation_playing = false
	if _name == "show":
		_start_timer()
	elif _name == "hide":
		_end()