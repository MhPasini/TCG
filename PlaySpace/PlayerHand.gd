@tool
extends Node2D

const cardBase = preload("res://Cards/card_base.tscn")
const playerData := preload("res://Data/PlayerData.tres")


@export_group('Hand Fan Variables')
@export var maxRange = 200 : set = _update_range
@export var maxHeight = 30 : set = _update_height
@export var maxAngle = 10 : set = _update_angle
@export var spreadCurve : Curve
@export var heightCurve : Curve
@export var rotationCurve : Curve
@export var inHandScale := 0.45

var handSize : int
@onready var game = $".."

func _ready():
	if !Engine.is_editor_hint():
		for i in get_children():
			i.queue_free()

func spawnCard(card:String) -> void:
	var newCard = cardBase.instantiate()
	playerData.hand.append(newCard)
	newCard.cardName = card
	newCard.scale *= inHandScale
	newCard.position = game.player_deck.position
	add_child(newCard)
	move_child(newCard, 0)
	handSize = playerData.hand.size()
	calcCardsPos()

func calcCardsPos() -> void:
	var cardCount = get_child_count()
	for card in get_children():
		if card is BaseCard:
			var handRatio = 0.5
			var posAjust = max(1, (5 - cardCount))
			if cardCount > 1:
				handRatio = float(card.get_index()) / float(cardCount - 1)
			var pos = position
			pos.x += spreadCurve.sample(handRatio) * maxRange / posAjust
			pos.y -= heightCurve.sample(handRatio) * maxHeight / posAjust
			var rot = rotationCurve.sample(handRatio) * maxAngle / posAjust
			card.tweenToPosition(pos, rot)

func removeCard(card:BaseCard) -> void:
	if is_instance_valid(card): # checks if the card really exist
		playerData.hand.erase(card) # removes the card from hand array
		card.queue_free() # deletes card scene
		# wait for one process_frame, makes sure that the card was removed before organizing.
		await get_tree().process_frame 
		calcCardsPos() # re-organize cards position

func _on_player_deck_add_card(card:String) -> void:
	spawnCard(card)



######### TESTING ########################

func _update_range(v) ->void:
	maxRange = v
	calcCardsPos()

func _update_height(v) ->void:
	maxHeight = v
	calcCardsPos()

func _update_angle(v) ->void:
	maxAngle = v
	calcCardsPos()

##########################################
