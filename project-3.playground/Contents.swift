//============================
// MARK: - Importations
//============================
import PlaygroundSupport

//============================
// MARK: - Tests
//============================
var mage: Magus
mage = Magus(name: "Mage")
mage.name
mage.health
mage.weapon.name
mage.weapon.power
mage.isAlive

var combatant: Fighter
combatant = Fighter(name: "Combatant")
combatant.name
combatant.health
combatant.weapon.name
combatant.weapon.power
combatant.isAlive

var colosse: Colossus
colosse = Colossus(name: "Colosse")
colosse.name
colosse.health
colosse.weapon.name
colosse.weapon.power
colosse.isAlive

var nain: Dwarf
nain = Dwarf(name: "Nain")
nain.name
nain.health
nain.weapon.name
nain.weapon.power
nain.isAlive

// Modification des points de vie du nain pour les tests
nain.health = 11


// Le nain en prend une.
combatant.attack(target: nain)
nain.name
nain.health
nain.weapon.name
nain.weapon.power
nain.isAlive
