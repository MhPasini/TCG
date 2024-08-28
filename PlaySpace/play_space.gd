extends Node2D
class_name PlaySpaceClass

const cardBase = preload("res://Cards/card_base.tscn")
const playerHand = preload("res://Data/player_hand.gd")

var cardSelected : String

@onready var deckSize : int = playerHand.CardList.size()

func _ready() -> void:
	pass

func _input(_event):
	if Input.is_action_just_released('leftclick'):
		spawnCard()

# TUDO PROVISÓRIO
func spawnCard() -> void:
	var newCard = cardBase.instantiate()
	cardSelected = playerHand.CardList[randi() % deckSize] #seleciona carta aleatoria
	newCard.cardName = cardSelected
	newCard.scale *= 0.75
	newCard.position = get_global_mouse_position()
	$Cards.add_child(newCard)
