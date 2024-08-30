extends Node2D


const playerData := preload("res://Data/PlayerData.tres")
var deckSize : int : set = _setDeckSize

signal addCard(card)
signal noCardLeft

func _ready():
	randomize()
	shuffleDeck()
	deckSize = playerData.deck.size()

func drawCard() -> void:
	var newCard = playerData.deck.pop_back()
	if newCard != null:
		playerData.hand.append(newCard)
		emit_signal("addCard", newCard)
		deckSize -= 1
	else:
		emit_signal("noCardLeft")

func shuffleDeck() -> void:
	playerData.deck.shuffle()

func _setDeckSize(size) -> void:
	deckSize = size
	if size == 0:
		hide()
