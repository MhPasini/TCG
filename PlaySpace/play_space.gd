extends Node
class_name PlaySpaceClass

@export_group('Area Variables')
@export var maxRange = 450
@export var hozAjust = 10
@export var spreadCurve : Curve

@onready var cards = $PlayerArea/Cards


func _ready() -> void:
	for card in cards.get_children():
		card.queue_free()


func calcCardsPos() -> void:
	var cardCount = cards.get_child_count() # this returns the number of nodes under Cards node (child)
	for card in cards.get_children(): # iterate once for each card (children)
		if card is BaseCard: # makes sure that it is a card (should always be true)
			var handRatio = 0.5 # represents where the card is located (0.5 = middle)
			
			var posAjust = max(1, (hozAjust - cardCount)) #melhorar isso
			
			if cardCount > 1: # if there is only one card it is in the middle (0.5)
				handRatio = float(card.get_index()) / float(cardCount - 1) # if not, calculate the ratio
			var pos = cards.global_position # initial position
			pos.x += spreadCurve.sample(handRatio) * maxRange / posAjust # get new position using the curves
			card.tweenToPosition(pos) # animate the card to the new position


func _on_area_2d_area_entered(area):
	var card = area.get_parent() as BaseCard
	if card.pickedUp:
		card.inHand = false
		print('entered play area')


func _on_area_2d_area_exited(area):
	var card = area.get_parent() as BaseCard
	if is_instance_valid(card) and !card.played:
		card.inHand = true
		print('exited play area')

