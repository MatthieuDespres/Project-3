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


// Le nain en prend une.
combatant.attack(target: nain)
nain.name
nain.health
nain.weapon.name
nain.weapon.power
nain.isAlive

var arme: Weapon
arme = Weapon(category: Weapon.Category.sword, material: Weapon.Material.diamond)
arme.name
arme.power
var baton = Weapon(category: Weapon.Category.stick, material: Weapon.Material.diamond)

combatant.checkUse(weapon: arme)
colosse.checkUse(weapon: arme)
nain.checkUse(weapon: arme)
mage.checkUse(weapon: arme)
mage.equip(weapon: baton)

combatant.equip(weapon: arme)
combatant.weapon.name
combatant.weapon.power

combatant.attack(target: nain)
nain.name
nain.health
nain.weapon.name
nain.weapon.power
nain.isAlive

mage.heal(target: nain)
nain.name
nain.health
nain.weapon.name
nain.weapon.power
nain.isAlive
