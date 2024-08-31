extends Resource
class_name CardDatabase

enum {Ghoul, Cultist, MinorDemon}

# card = ['type', 'name', cost, atk, health, 'special', 'description']

const CARDS = ['Ghoul', 'Cultist', 'MinorDemon']

const DATA = {
	Ghoul :
		['Units', 'Ghoul', 200, 350, 150, 'None', 'Descrição da habilidade aqui.'],
	Cultist :
		['Units', 'Cultist', 400, 300, 500, 'None', 'Descrição da habilidade aqui.'],
	MinorDemon :
		['Units', 'Demon', 400, 300, 500, 'None', 'Descrição da habilidade aqui.']
}
