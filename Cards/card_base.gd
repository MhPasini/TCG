extends Node2D
class_name BaseCard

var cardsDatabase := CardDatabase.new()
var cardName := 'Cultist'
var restPos : Vector2
var restRot : float
var handIndex : int
var pressed := false
var relative_pos := Vector2.ZERO
var slot = null

enum CardState { IN_HAND, PICKED_UP, PLAYED, MOVING }
var state: CardState = CardState.IN_HAND

@export var inHandScale := 0.45
@export var inGameScale := 0.45

@onready var cardInfo : Array = cardsDatabase.DATA[cardsDatabase.get(cardName)]
@onready var cardImg = str("res://Cards/", cardInfo[0], '/', cardName, '.png')
@onready var cardTypeImg = str("res://Cards/TypeIcons/", cardInfo[0], '.png')
@onready var card = $SubViewportContainer/SubViewport/Card
@onready var cardMaterial = $SubViewportContainer.material as ShaderMaterial

signal playSelf


func _ready() -> void:
	card.loadCardInfo(cardImg, cardTypeImg, cardInfo)
	handIndex = get_index()


func _process(delta):
	if state == CardState.PICKED_UP:
		global_position = get_global_mouse_position() + relative_pos


func tweenToPosition(pos:Vector2, rot:float = 0.0) -> void:
	var t = create_tween().set_parallel()
	t.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	t.tween_property(self, 'position', pos, 0.5)
	t.tween_property(self, 'rotation_degrees', rot, 0.5)
	restPos = pos
	restRot = rot

func focusSelf() -> void:
	cardMaterial.set_shader_parameter('outline_on', true)
	if state == CardState.IN_HAND:
		scale *= 1.25
		handIndex = get_index()
		move_to_front()
		var t = create_tween().set_parallel()
		t.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUINT)
		t.tween_property(self, 'position', Vector2.UP * 100, 0.4).as_relative().from(restPos)
		t.tween_property(self, 'rotation_degrees', 0, 0.4)

func removeFocus() -> void:
	cardMaterial.set_shader_parameter('outline_on', false)
	if state == CardState.IN_HAND:
		scale = Vector2.ONE * inHandScale
		get_parent().move_child(self, handIndex)
		var t = create_tween().set_parallel()
		t.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
		t.tween_property(self, 'position', restPos, 0.4)
		t.tween_property(self, 'rotation_degrees', restRot, 0.4)
		await t.finished

func _on_detection_area_mouse_entered() -> void:
	focusSelf()

func _on_detection_area_mouse_exited() -> void:
	removeFocus()

func playCard() -> void:
	state = CardState.PLAYED
	scale = Vector2.ONE * inGameScale
	cardMaterial.set_shader_parameter('outline_on', false)
	playSelf.emit(self, slot)
	# call card effects


func _on_detection_area_gui_input(event):
	if event is InputEvent:
		if event.is_action_pressed("leftclick"):
			pressed = true
			relative_pos = global_position - get_global_mouse_position()
		elif event.is_action_released("leftclick") and pressed:
			pressed = false
			if state == CardState.PICKED_UP:
				if slot:
					playCard()
				else:
					removeFocus()
					state = CardState.IN_HAND
		if event is InputEventMouseMotion and pressed and state != CardState.PLAYED:
			state = CardState.PICKED_UP
