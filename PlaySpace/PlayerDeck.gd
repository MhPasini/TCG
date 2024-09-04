extends Node2D


const playerData := preload("res://Data/PlayerData.tres")
var deckSize : int : set = _setDeckSize

signal addCard(card)
signal noCardLeft

func _ready():
	randomize() # randomize the seed for the RNG
	shuffleDeck() # shuffle the cards in the deck
	deckSize = playerData.deck.size() # get the size of the cards list

func drawCard() -> void:
	var newCard = playerData.deck.pop_back() # get the name of the new card
	if newCard != null: # if the name is not null
		emit_signal("addCard", newCard) # emit a signal that is connected to playerHand
		deckSize -= 1
	else:
		print("Deck is Empty!")
		emit_signal("noCardLeft") #  emit a signal that is connected to the game scene

func shuffleDeck() -> void:
	playerData.deck.shuffle() # randomise cards order

func _setDeckSize(size) -> void:
	deckSize = size
	
	$CardCount.text = str(deckSize) # updates the cardCount label
	
	if size == 0:
		hide()
	else:
		show()
