import Foundation
//==================================================
// MARK: - Model
//==================================================
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
    public init() {
        self.teams = [Team]()
        self.rounds = [Round]()
    }
    public func addTeam(team: Team) {
        teams.append(team)
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
//==================================================
// MARK: - View
//==================================================
// MARK: - Display
public class Display {
    private let interfaceLineLength: Int = 70
    private let gameTitle: String
    // MARK: Draw and Speak Methods
    public init() {
        gameTitle = "Le choc des brutes"
        clearScreen()
    }
    public func sayWelcome() {
        drawFrameOneLine(text: gameTitle)
    }
    // TODO: question pour Ambroise Faire un méthode privé pour juste un if?
    public func drawLine(motif: String) {
        var line: String = ""
        var startAndStopMotif: String = "+"
        for _ in 1...interfaceLineLength {
            line += motif
        }
        if motif == " " {
            startAndStopMotif = "|"
        }
        line = startAndStopMotif + line + startAndStopMotif
        print(line)
    }
    private func center(text: String) {
        print("|\(prepareCenter(text: text))|")
    }
    private func prepareCenter(text: String) -> String {
        let prefix: Int = (interfaceLineLength - text.count) / 2
        let suffix: Int = (interfaceLineLength - text.count - prefix)
        var lineText: String = ""
        for _ in 1...prefix {
            lineText += " "
        }
        lineText += text
        for _ in 1...suffix {
            lineText += " "
        }
        return lineText
    }
    public func drawFrameOneLine(text: String) {
        drawLine(motif: "-")
        drawLine(motif: " ")
        center(text: text)
        drawLine(motif: " ")
        drawLine(motif: "-")
    }
    public func drawFrameMultiLinesWithTitle(lines: [String], title: String) {
        drawLine(motif: "-")
        center(text: title)
        drawLine(motif: " ")
        allignLeft2(lines: lines)
        drawLine(motif: " ")
        drawLine(motif: "-")
    }
    private func drawFrameMultiLines(lines: [String]) {
        drawLine(motif: "-")
        drawLine(motif: " ")
        allignLeft(lines: lines)
        drawLine(motif: " ")
        drawLine(motif: "-")
    }
    // TODO: Comprendre ce bug pourquoi des fois il faut un -1 et pas d'autre.
    private func allignLeft(lines: [String]) {
        for line in lines {
            print("|\(prepareAllignLeft(text: line))|")
        }
    }
    private func prepareAllignLeft(text: String) -> String {
        let suffix: Int = interfaceLineLength - text.count - 1
        var lineText: String = text
        for _ in 1...suffix {
            lineText += " "
        }
        return lineText
    }
    private func allignLeft2(lines: [String]) {
        for line in lines {
            print("|\(prepareAllignLeft2(text: line))|")
        }
    }
    private func prepareAllignLeft2(text: String) -> String {
        let suffix: Int = interfaceLineLength - text.count
        var lineText: String = text
        for _ in 1...suffix {
            lineText += " "
        }
        return lineText
    }
    public enum gmMood: String {
        case normal = "📜"
        case error = "😡"
    }
    public func gmSpeak(text: String, mood: gmMood) {
        print("\(mood.rawValue) \(text)")
    }
    // TODO: Amélioré la lisibilitée Un tableau par exemple.
    func showCharactersTypes() {
        var lines = [String]()
        lines.append("1-🤺 Combatant: Épée à la main, il incarne la polyvalence au combat.")
        lines.append("2-🧙🏻‍♂️ Mage: Avec son baton il soigne les blessures de son équipe.")
        lines.append("3-👨🏻‍🚀 Colosse: Protégé derrière son bouclier il est très résistant.")
        lines.append("4-💂🏻‍♂️ Nain: Une hache à la main il est un tueur né.")
        
        drawFrameMultiLines(lines: lines)
    }
    // MARK: Read Methods
    // TODO: Ici clairement le else du if ne sert à rien mais j'arrive pas à l'enlever.
    public func readString() -> String{
        if let playerResponse = readLine() {
            guard isUsableString(text: playerResponse) else {
                gmSpeak(text: "ERREUR: Le maitre du jeu apprécierait une réponse.", mood: Display.gmMood.error)
                return readString()
            }
            return playerResponse
        } else {
            gmSpeak(text: "ERREUR: Le maitre du jeu apprécierait une réponse.", mood: Display.gmMood.error)
            return readString()
        }
    }
    // TODO: Utilisation d'expression régulière pour éviter les saisie de "" ou " " ou "     "...
    private func isUsableString(text: String) -> Bool {
        guard text != "" && text != " " else {
            return false
        }
        return true
    }
    public func readInt() -> Int {
        if let playerInt = Int(readString()) {
            return playerInt
        } else {
            gmSpeak(text: "ERREUR: Ici la réponse appropriée est un nombre.", mood: Display.gmMood.error)
            return readInt()
        }
    }
    public func readIntBetween(min: Int, max: Int) -> Int {
        let controlInt: Int = readInt()
        guard controlInt >= min && controlInt <= max else {
            gmSpeak(text: "ERREUR: La valeur attendue doit être comprise entre \(min) et \(max).", mood: Display.gmMood.error)
            return readIntBetween(min: min, max: max)
        }
        return controlInt
    }
    // MARK: Clear Methods
    public func clearScreen() {
        for _ in 1...20 {
            print("\n")
        }
    }
    public func clearAndTitle() {
        clearScreen()
        sayWelcome()
    }
}
//==================================================
// MARK: - Controller
//==================================================
public class StartGameController {
    private var display: Display
    private var game: Game
    public init() {
        self.display = Display()
        self.game = Game()
        createTeams()
        // TODO: Verrification complete si chaque objet a bien été crée.
        // TODO: Améliorer l'affichage des personnages que ce soit beau et alligner.
        print(game.rounds.count)
        print(game.teams.count)
    }
    private func createTeams() {
        for numPlayer in 1...2 {
            game.addTeam(team: createTeam(numPlayer: numPlayer))
        }
    }
    private func createTeam(numPlayer: Int) -> Team {
        display.clearAndTitle()
        let playerName: String = askPlayerName(numPlayer: numPlayer)
        return Team(player: playerName, characters: createCharacters(numPlayer: numPlayer, playerName: playerName))
    }
    private func askPlayerName(numPlayer: Int) -> String {
        display.gmSpeak(text: "Nom Joueur \(numPlayer) : ", mood: Display.gmMood.normal)
        return display.readString()
    }
    private func createCharacters(numPlayer: Int, playerName: String) -> [AnyObject] {
        var characters = [AnyObject]()
        let words: [Int: String] = [1: "premier", 2: "second", 3: "dernier"]
        for nbCharacters in 1...3 {
            display.clearAndTitle()
            display.drawFrameMultiLinesWithTitle(lines: charactersInfo(characters: characters), title: playerName)
            let characterName: String = askCharacterName(words: words, nbCharacters: nbCharacters)
            display.clearAndTitle()
            display.drawFrameMultiLinesWithTitle(lines: charactersInfo(characters: characters), title: playerName)
            let characterType: Int = askCharacterType(words: words, nbCharacters: nbCharacters, characterName: characterName)
            characters.append(createCharacter(characterName: characterName, characterType: characterType))
        }
        return characters
    }
    private func askCharacterName(words: [Int: String], nbCharacters: Int) -> String {
        display.gmSpeak(text: "Choisis le nom de ton \(words[nbCharacters]!) personnage :", mood: Display.gmMood.normal)
        return display.readString()
    }
    private func askCharacterType(words: [Int: String], nbCharacters: Int, characterName: String) -> Int {
        display.showCharactersTypes()
        display.gmSpeak(text: "Choisis la classe de \(characterName), ton \(words[nbCharacters]!) personnage :", mood: Display.gmMood.normal)
        return display.readIntBetween(min: 1, max: 4)
    }
    private func createCharacter(characterName: String, characterType: Int) -> AnyObject {
        // TODO: ASK : Simplifier avec la reflexion?
        switch characterType {
        case 1:
            return Fighter(name: characterName)
        case 2:
            return Magus(name: characterName)
        case 3:
            return Colossus(name: characterName)
        case 4:
            return Dwarf(name: characterName)
        default:
            break
        }
        // TODO: ASK: Im m'oblige un return ça fait chier.
        return Fighter(name: characterName)
    }
    private func charactersInfo(characters: [AnyObject]) -> [String] {
        var characterLines = [String]()
        for character in characters {
            characterLines.append(characterInfo(character: character))
        }
        for _ in 0...calculateEmptyLines(characterLines: characterLines) {
            characterLines.append(emptyLine())
        }
        return characterLines
    }
    private func characterInfo(character: AnyObject) -> String {
        return "\(getCharacterTypeIcone(character: character)) \((character as! GameCharacter).name) | ❤️ : \((character as! GameCharacter).health)"
    }
    private func getCharacterTypeIcone(character: AnyObject) -> String {
        var icon: String = ""
        switch String(describing: type(of: character)) {
        case "Fighter":
            icon = "🤺"
        case "Magus":
            icon = "🧙🏻‍♂️"
        case "Colossus":
            icon = "👨🏻‍🚀"
        case "Dwarf":
            icon = "💂🏻‍♂️"
        default:
            break
        }
        return icon
    }
    private func emptyLine() -> String {
        return "En attente de recrutement."
    }
    private func calculateEmptyLines(characterLines: [String]) -> Int {
        return (3 - characterLines.count) - 1
    }
}
//==================================================
// MARK: - Main
//==================================================
var startGameController: StartGameController = StartGameController()
