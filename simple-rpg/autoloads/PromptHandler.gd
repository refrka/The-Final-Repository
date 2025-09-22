extends Node



var notice_scene = preload("res://scenes/prompts/notice.tscn")


var notice_list: Array




func notice(message: String) -> void:
	var scene = notice_scene.instantiate()
	scene.setup(message)
	scene.notice_ended.connect(_end_notice.bind(scene))
	if notice_list.size() > 0:
		var last_notice = notice_list.back()
		last_notice.notice_ended.connect(_add_notice.bind(scene))
		notice_list.append(scene)
	else:
		_add_notice(scene)
		notice_list.append(scene)


func _end_notice(_notice: Node) -> void:
	notice_list.erase(_notice)
	_notice.queue_free.call_deferred()


func _add_notice(_notice: Node) -> void:
	var root = get_tree().get_first_node_in_group("prompt_root")
	root.add_child(_notice)
	_notice.start()