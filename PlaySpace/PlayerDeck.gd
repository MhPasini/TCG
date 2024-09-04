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
		emit_signal("addCard", newCard)
		deckSize -= 1
	else:
		print("Deck is Empty!")
		emit_signal("noCardLeft")

func shuffleDeck() -> void:
	playerData.deck.shuffle()

func _setDeckSize(size) -> void:
	deckSize = size
	
	$CardCount.text = str(size)
	
	if size == 0:
		hide()
	else:
		show()
