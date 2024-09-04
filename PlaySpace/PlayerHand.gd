extends Node2D

const cardBase = preload("res://Cards/card_base.tscn")
const playerData := preload("res://Data/PlayerData.tres")


@export_group('Hand Fan Variables')
@export var maxRange = 200
@export var maxHeight = 30
@export var maxAngle = 10
@export var spreadCurve : Curve
@export var heightCurve : Curve
@export var rotationCurve : Curve
@export var inHandScale := 0.45

var handSize : int
@onready var game = $".."
@onready var cards = $Cards

func _ready():
	for i in cards.get_children(): # will delete all the cards on hand
		i.queue_free()

func spawnCard(card:String) -> void:
	var newCard = cardBase.instantiate() # create a instance of the cardBase (instance name is newCard)
	playerData.hand.append(newCard) # add the instance reference to playerData.hand
	newCard.cardName = card # configure the newCard's name, received as argument
	newCard.scale *= inHandScale # configures the card scale
	newCard.position = game.player_deck.position # places the newCard on top of the deck (for animation)
	newCard.playSelf.connect(game._on_card_playSelf) # connect the playSelf signal to game scene
	cards.add_child(newCard) # finally adds the newCard instance to the scene
	cards.move_child(newCard, 0) # move the card order in the node tree ( 0 is drawn on top )
	handSize = playerData.hand.size() # update the playerData.hand size
	calcCardsPos() # call the function for organizing the cards on hand

func calcCardsPos() -> void:
	var cardCount = cards.get_child_count() # this returns the number of nodes under Cards node (child)
	for card in cards.get_children(): # iterate once for each card (children)
		if card is BaseCard: # makes sure that it is a card (should always be true)
			var handRatio = 0.5 # represents where the card is located on the hand (0.5 = middle)
			var posAjust = max(1, (5 - cardCount)) # ajust the horizontal spread for cards in hand
			if cardCount > 1: # if there is only one card it is in the middle (0.5)
				handRatio = float(card.get_index()) / float(cardCount - 1) # if not, calculate the ratio
			var pos = position # initial position is the middle of the hand (0,0) relative to playerHand
			pos.x += spreadCurve.sample(handRatio) * maxRange / posAjust # get new position using the curves
			pos.y -= heightCurve.sample(handRatio) * maxHeight / posAjust
			var rot = rotationCurve.sample(handRatio) * maxAngle / posAjust
			card.tweenToPosition(pos, rot) # animate the card to the new position

func removeCard(card:BaseCard) -> void:
	if is_instance_valid(card): # checks if the card really exist
		playerData.hand.erase(card) # removes the card from hand array
		card.queue_free() # deletes card scene
		# wait for one process_frame, makes sure that the card was removed before organizing.
		await get_tree().process_frame 
		calcCardsPos() # re-organize cards position

func _on_player_deck_add_card(card:String) -> void:
	spawnCard(card)

