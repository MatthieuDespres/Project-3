import Foundation
// MARK: - A OPTIMISER
// TODO: Teams creator (Surement dans la classe Game)
func createTeams() {
    var numPlayer: Int = 1
    while numPlayer <= 2 {
        var playerName: String
        display.gmSpeak(text: "Nom Joueur \(numPlayer) : ")
        playerName = display.readPlayerReply()
        if playerName == "" {
            playerName = "Joueur \(numPlayer)"
        }
        createCharacters(numPlayer: numPlayer, playerName: playerName)
        numPlayer += 1
        //Retourné un tableau d'équipe
    }
}
// TODO: Characters creator (Surement dans la classe team)
func createCharacters(numPlayer: Int, playerName: String) {
    display.gmSpeak(text:"\(playerName) il est temps de constituer ton équipe.")
    var nbCharacters: Int = 0
    var characterNumber: String
    while nbCharacters < 3 {
        var characterName: String
        switch nbCharacters {
        case 0:
            display.gmSpeak(text: "Choisis le nom de ton premier personnage :")
        case 1:
            display.gmSpeak(text: "Choisis le nom de ton second personnage :")
        case 2:
            display.gmSpeak(text: "Choisis le nom de ton dernier personnage :")
        default:
            display.gmSpeak(text: "Ce cas n'arrive jamais. Ou alors j'ai merder quelque part.")
        }
        characterName = display.readPlayerReply()
        showCharactersTypes()
        switch nbCharacters {
        case 0:
            display.gmSpeak(text: "Choisis la classe de \(characterName), ton premier personnage :")
        case 1:
            display.gmSpeak(text: "Choisis la classe de \(characterName), ton second personnage :")
        case 2:
            display.gmSpeak(text: "Choisis la classe de \(characterName), ton dernier personnage :")
        default:
            display.gmSpeak(text: "Ce cas n'arrive jamais. Ou alors j'ai merder quelque part.")
        }
        characterNumber = display.readPlayerReply()
        switch characterNumber {
        case "1":
            if characterName == "" {
                characterName = "Combatant sans nom"
            }
            display.gmSpeak(text: "\(characterName) est un combatant.")
            //Crée obj et ajouter a une collec
        case "2":
            if characterName == "" {
                characterName = "Mage sans nom"
            }
            display.gmSpeak(text: "\(characterName) est un mage.")
            //Crée obj et ajouter a une collec
        case "3":
            if characterName == "" {
                characterName = "Colosse sans nom"
            }
            display.gmSpeak(text: "\(characterName) est un colosse.")
            //Crée obj et ajouter a une collec
        case "4":
            if characterName == "" {
                characterName = "Nain sans nom"
            }
            display.gmSpeak(text: "\(characterName) est un nain.")
            //Crée obj et ajouter a une collec
        default:
            if characterName == "" {
                characterName = "Combatant sans nom"
            }
            display.gmSpeak(text: "\(characterName) est un combatant.")
            //Crée obj et ajouter a une collec
        }
        nbCharacters += 1
        //Reourner la collection de personnage.
    }
}
// TODO: Pourquoi pas en méthode static dans GameCharacters? mais c'est de l'affichange dans un class non dédié à ça.
func showCharactersTypes() {
    print(" 1 - 🤺 Combatant: Épée à la main, il incarne la polyvalence au combat.")
    print(" 2 - 🧙🏻‍♂️ Mage: Avec son baton il soigne les blessures de son équipe.")
    print(" 3 - 👨🏻‍🚀 Colosse: Protégé derrière son bouclier il est très résistant.")
    print(" 4 - 💂🏻‍♂️ Nain: Une hache à la main il est un tueur né.")
}
// MARK: - All Classes
// MARK: - Colossus
public class Colossus: Warrior {
    private static let colossusHealthMax: Int = 200
    public override init(name: String) {
        super.init(name: name)
        health = Colossus.colossusHealthMax
        healthMax = Colossus.colossusHealthMax
        weapon = Colossus.createBaseWeapon()
    }
    public func checkUse(weapon: Weapon) -> Bool {
        if weapon.category == Weapon.Category.shield {
            return true
        } else {
            return false
        }
    }
    private static func createBaseWeapon() -> Weapon {
        return Weapon(category: Weapon.Category.shield, material: Weapon.Material.wood)
    }
}
// MARK: - Dwarf
public class Dwarf: Warrior {
    private static let dwarfHealthMax: Int = 50
    public override init(name: String) {
        super.init(name: name)
        health = Dwarf.dwarfHealthMax
        healthMax = Dwarf.dwarfHealthMax
        weapon = Dwarf.createBaseWeapon()
    }
    public func checkUse(weapon: Weapon) -> Bool {
        if weapon.category == Weapon.Category.ax {
            return true
        } else {
            return false
        }
    }
    private static func createBaseWeapon() -> Weapon {
        return Weapon(category: Weapon.Category.ax, material: Weapon.Material.wood)
    }
}
// MARK: - Fighter
public class Fighter: Warrior {
    private static let fighterHealthMax: Int = 100
    public override init(name: String) {
        super.init(name: name)
        health = Fighter.fighterHealthMax
        healthMax = Fighter.fighterHealthMax
        weapon = Fighter.createBaseWeapon()
    }
    public func checkUse(weapon: Weapon) -> Bool {
        if weapon.category == Weapon.Category.sword {
            return true
        } else {
            return false
        }
    }
    private static func createBaseWeapon() -> Weapon {
        return Weapon(category: Weapon.Category.sword, material: Weapon.Material.wood)
    }
}
// MARK: - Magus
public class Magus: GameCharacter {
    private static let magusHealthMax: Int = 50
    public override init(name: String) {
        super.init(name: name)
        health = Magus.magusHealthMax
        healthMax = Magus.magusHealthMax
        weapon = Magus.createBaseWeapon()
    }
    public func heal(target: GameCharacter) -> Round.ActionStatus {
        if target.isAlive {
            target.health += getHealPoint(target: target)
            return Round.ActionStatus.noError
        } else {
            return Round.ActionStatus.healDeadError
        }
    }
    public func checkUse(weapon: Weapon) -> Bool {
        if weapon.category == Weapon.Category.stick {
            return true
        } else {
            return false
        }
    }
    private static func createBaseWeapon() -> Weapon {
        return Weapon(category: Weapon.Category.stick, material: Weapon.Material.wood)
    }
    private func getHealPoint(target: GameCharacter)-> Int {
        if (target.health + weapon.power) <= target.healthMax {
            return weapon.power
        }
        else {
            return target.healthMax - target.health
        }
    }
}
// MARK: - Warrior
public class Warrior: GameCharacter {
    public func attack(target: GameCharacter)-> Round.ActionStatus {
        if target.isAlive {
            target.health -= getDamagePoint(target: target)
            return Round.ActionStatus.noError
        } else {
            return Round.ActionStatus.attackDeadError
        }
    }
    private func getDamagePoint(target: GameCharacter) -> Int{
        if (target.health - weapon.power) >= 0 {
            return weapon.power
        } else {
            return target.health
        }
    }
}
// MARK: - GameCharacter
public class GameCharacter {
    public let name: String
    public var health: Int {
        didSet {
            isAlive = getLifeStatus(health: health)
        }
    }
    public var weapon: Weapon
    public var healthMax: Int
    public var isAlive: Bool
    private static let characterHealthMax: Int = 0
    public enum Job: String {
        case fighter = "combatant"
        case magus = "mage"
        case colossus = "colosse"
        case dwarf = "nain"
    }
    public init(name: String) {
        self.name = name
        health = GameCharacter.characterHealthMax
        healthMax = GameCharacter.characterHealthMax
        weapon = GameCharacter.createBaseWeapon()
        isAlive = true
    }
    public func equip(weapon: Weapon) {
        self.weapon = weapon
    }
    private static func createBaseWeapon() -> Weapon {
        return Weapon(category: Weapon.Category.sword, material: Weapon.Material.wood)
    }
    private func getLifeStatus(health: Int)-> Bool {
        if health > 0 {
            return true
        }
        else {
            return false
        }
    }
}
// MARK: - Team
// TODO: Idée, initialiser characters comme vide et faire des méthodes "createCharacter", "addCharacter".
public class Team {
    public let player: String
    public var characters: [AnyObject]
    public var nbCharacterAlive: Int {
        return countCharacterAlive()
    }
    public init(player: String, characters: [AnyObject]) {
        self.player = player
        self.characters = characters
    }
    private func countCharacterAlive() -> Int {
        var nbCharacterAlive: Int = 0
        for character in characters {
            if (character as! GameCharacter).isAlive{
                nbCharacterAlive += 1
            }
        }
        return nbCharacterAlive
    }
}
// MARK: - Weapon
public class Weapon {
    public let category: Category
    private let material: Material
    private let totem: Totem
    public var power: Int {
        return getCategoryPower() + getMaterialPower()
    }
    public var name: String {
        return "\(category.rawValue) \(material.rawValue) \(totem.rawValue)"
    }
    public enum Category: String {
        case sword = "Épée"
        case stick = "Bâton"
        case shield = "Bouclier"
        case ax = "Hache"
        static var random: Category {
            let category = [Category.sword, Category.stick, Category.shield, Category.ax]
            return category[Int(arc4random_uniform(UInt32(category.count)))]
        }
    }
    public enum Material: String {
        case wood = "en bois"
        case iron = "de fer"
        case diamond = "de diamant"
        static var random: Material {
            let material = [Material.wood, Material.iron, Material.diamond]
            return material[Int(arc4random_uniform(UInt32(material.count)))]
        }
    }
    private enum Totem: String {
        case owl = "de la chouette"
        case panda = "du panda"
        case weasel = "de la belette"
        case mongoose = "de la mangouste"
        case rat = "du rat"
        case eagle = "de l'aigle"
        case pony = "du poney"
        case doowy = "de Doowy l'oeuvre d'art"
        static var random: Totem {
            let totems = [Totem.owl, Totem.panda, Totem.weasel, Totem.mongoose, Totem.rat, Totem.eagle, Totem.pony, Totem.doowy]
            return totems[Int(arc4random_uniform(UInt32(totems.count)))]
        }
    }
    public init(category: Category, material: Material) {
        self.category = category
        self.material = material
        self.totem = Totem.random
    }
    public static func createRandom()-> Weapon {
        return Weapon(category: Category.random, material: Material.random)
    }
    private func getCategoryPower() -> Int {
        switch category {
        case .sword:
            return 10
        case .stick:
            return 20
        case .shield:
            return 5
        case .ax:
            return 20
        }
    }
    private func getMaterialPower() -> Int {
        switch material {
        case .wood:
            return 0
        case .iron:
            return 5
        case .diamond:
            return 10
        }
    }
}
// MARK: - Round
public class Round {
    private let activeTeam: Team
    private let targetTeam: Team
    private var activeCharacter: GameCharacter
    private var targetCharacter: GameCharacter
    private let actionType: ActionType
    private let healthPoint: Int
    private var isTeamMate: Bool {
        return checkPlayersName()
    }
    public enum ActionType: String {
        case attack = "attaque"
        case heal = "soigne"
    }
    public enum ActionStatus: String {
        case noError = "Action réalisée"
        case attackTeamMateError = "ERREUR : Ne peut attaquer un coéquipier."
        case healEnemyError = "ERREUR : Ne peut soigner un ennemi."
        case magusAttackError = "ERREUR : Les mages ne peuvent pas attaquer."
        case warriorHealError = "ERREUR : Seul les mages peuvent soigner."
        case attackDeadError = "ERREUR : La cible de l'attaque est déja morte."
        case healDeadError = "ERREUR : La cible du soins est déja morte."
        case attackHimself = "ERREUR : Le personnage ne peut s'attaquer lui-même."
    }
    public init(activeTeam: Team, targetTeam: Team, activeCharacter: GameCharacter, targetCharacter: GameCharacter, actionType: ActionType) {
        self.activeTeam = activeTeam
        self.targetTeam = targetTeam
        self.activeCharacter = activeCharacter
        self.targetCharacter = targetCharacter
        self.actionType = actionType
        self.healthPoint =  activeCharacter.weapon.power
    }
    //TODO: Trouver un nom plus cohérent.
    public func executeAction() -> Round.ActionStatus {
        switch actionType {
        case Round.ActionType.attack:
            return attack()
        case Round.ActionType.heal:
            return heal()
        }
    }
    private func checkPlayersName() -> Bool {
        if activeTeam.player == targetTeam.player {
            return true
        } else {
            return false
        }
    }
    private func isChestAvailable() -> Bool {
        if Int(arc4random_uniform(UInt32(2))) > 0 {
            return true
        } else {
            return false
        }
    }
    private func openChest()-> Weapon {
        return Weapon.createRandom()
    }
    private func attack() -> Round.ActionStatus {
        guard activeCharacter.name != targetCharacter.name else {
            return Round.ActionStatus.attackHimself
        }
        guard activeCharacter is Warrior else {
            return Round.ActionStatus.magusAttackError
        }
        guard !isTeamMate else {
            return Round.ActionStatus.attackTeamMateError
        }
        return (activeCharacter as! Warrior).attack(target: targetCharacter)
    }
    private func heal() -> Round.ActionStatus {
        guard activeCharacter is Magus else {
            return Round.ActionStatus.warriorHealError
        }
        guard isTeamMate else {
            return Round.ActionStatus.healEnemyError
        }
        return (activeCharacter as! Magus).heal(target: targetCharacter)
    }
}
// MARK: - Game
// TODO: Idée, à l'initialisation, initialisé teams comme vide et faire les méthodes "createTeams", "addTeam".
public class Game {
    private var teams: [Team]
    private var rounds: [Round]
    private static let nbMaxTeam: Int = 2
    private var isOver: Bool {
        if findLooser() != nil {
            return true
        } else {
            return false
        }
    }
    public init(teams: [Team]) {
        self.teams = teams
        self.rounds = [Round]()
    }
    private func findWinner() -> Team? {
        for team in teams {
            if let loosingTeam = findLooser() {
                if team.player != loosingTeam.player {
                    return team
                }
            }
        }
        return nil
    }
    private func findLooser() -> Team? {
        for team in teams {
            if team.nbCharacterAlive == 0 {
                return team
            }
        }
        return nil
    }
}
// MARK: - Display
public class Display {
    private let interfaceLineLength: Int = 60
    // MARK: Draw Methods
    public init(welcomeWord: String) {
        sayWelcome(welcomeWord: welcomeWord)
    }
    private func sayWelcome(welcomeWord: String) {
        drawFrameOneText(text: welcomeWord)
    }
    public func drawSimpleLine() {
        var line: String = "+"
        for _ in 1...self.interfaceLineLength {
            line += "-"
        }
        line += "+"
        print(line)
    }
    public func drawDoubleLine() {
        var line: String = "+"
        for _ in 1...self.interfaceLineLength {
            line += "="
        }
        line += "+"
        print(line)
    }
    public func drawEmptyLine() {
        var line: String = "|"
        for _ in 1...self.interfaceLineLength {
            line += " "
        }
        line += "|"
        print(line)
    }
    private func drawTextLine(text: String) {
        let nbChar: Int = text.count
        let prefix: Int = (self.interfaceLineLength - nbChar) / 2
        let suffix: Int = (self.interfaceLineLength - nbChar - prefix)
        var lineText: String = "|"
        for _ in 1...prefix {
            lineText += " "
        }
        lineText += text
        for _ in 1...suffix {
            lineText += " "
        }
        lineText += "|"
        print(lineText)
    }
    public func drawFrameOneText(text: String) {
        drawSimpleLine()
        drawEmptyLine()
        drawTextLine(text: text)
        drawEmptyLine()
        drawSimpleLine()
    }
    // MARK: MJ
    public func gmSpeak(text: String) {
        print("📜 \(text)")
    }
    // MARK: Read Methods
    public func readPlayerReply() -> String{
        if let playerResponse = readLine() {
            return playerResponse
        } else {
            return ""
        }
    }
    // MARK: Clear Methods
    public func clearScreen() {
        for _ in 1...20 {
            print("\n")
        }
    }
}
// MARK: - Main
var display: Display
display = Display(welcomeWord: "Le choc des brutes")
createTeams()




/*
 - Combatant : 🤺
 - Mage :🧙🏻‍♂️
 - Colosse :👨🏻‍🚀
 - Nain :💂🏻‍♂️
 - Épée :🗡
 - Bâton :🥖
 - Bouclier :🛡
 - Hache :⛏
 - Bois :🌲
 - Fer :🔩
 - Diamant :💎
 - Points de vie :❤️
 - Mort :☠️
 - Gagnant :🏆
 - Perdant :😭
 - Coffre :📦
 - Note MJ :📜
 */
