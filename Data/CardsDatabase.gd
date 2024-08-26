extends Resource
class_name CardDatabase

enum {Lich, Worm}

# card = ['type', 'name', cost, atk, health, 'special', 'description']

const DATA = {
	Lich :
		['Units', 'Lich', 200, 350, 150, 'None', 'A lich.'],
	Worm :
		['Units', 'Worm', 400, 300, 500, 'None', 'A big worm.']
}
