// TODO: Retirer tout les TODO.
// TODO: Essayer tant que possible d'utiliser des AnyObject.
// TODO: Chercher les méthodes inutilisé.
// TODO: Relire le cours sur la porté des méthodes tout ne doit pas etre public ou privé.
// TODO: Quand cela arrive , expliquer au joueur qu'on a automatiquement choisis le personage actif et ou le personnage cible.
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
    
    public override func checkUse(weapon: Weapon) -> Bool {
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
    
    public override func checkUse(weapon: Weapon) -> Bool {
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
    
    public override func checkUse(weapon: Weapon) -> Bool {
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
    
    public override func checkUse(weapon: Weapon) -> Bool {
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
    
    public func checkUse(weapon: Weapon) -> Bool {
        if weapon.category == Weapon.Category.sword {
            return true
        } else {
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
    
    public init(player: String) {
        self.player = player
        self.characters = [AnyObject]()
    }
    
    public func countCharacterAlive() -> Int {
        var nbCharacterAlive: Int = 0
        for character in characters {
            if (character as! GameCharacter).isAlive{
                nbCharacterAlive += 1
            }
        }
        return nbCharacterAlive
    }
    
    public func addCharacter(character: AnyObject) {
        characters.append(character)
    }
    
    // TODO: Retourner un GameCharacter
    public func getCharacter(name: String) -> AnyObject {
        var characterFind: AnyObject = characters[0]
        for character in characters {
            if (character as! GameCharacter).name.uppercased() == name.uppercased() {
                characterFind = character
            }
        }
        return characterFind
    }
    
    public func getCharactersAliveNames() -> [String] {
        var names = [String]()
        for character in characters {
            if (character as! GameCharacter).isAlive {
                names.append((character as! GameCharacter).name.uppercased())
            }
        }
        return names
    }
    
    public func getCharactersNamesCanEquip(weapon: Weapon) -> [String] {
        var names = [String]()
        for character in getCharacterCanEquip(weapon: weapon) {
            names.append(character.name.uppercased())
        }
        return names
    }
    
    public func getCharacterCanEquip(weapon: Weapon) -> [GameCharacter] {
        var characterCanEquip = [GameCharacter]()
        for character in characters {
            if (character as! GameCharacter).isAlive && (character as! GameCharacter).checkUse(weapon: weapon) {
                characterCanEquip.append((character as! GameCharacter))
            }
        }
        return characterCanEquip
    }
}

// MARK: - Weapon
public class Weapon {
    public let category: Category
    public let material: Material
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
    public let activeTeam: Team
    public let targetTeam: Team
    public var activeCharacter: GameCharacter
    public var targetCharacter: GameCharacter
    public let actionType: ActionType
    public let healthPoint: Int
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
    
    public init(activeTeam: Team, targetTeam: Team, activeCharacter: GameCharacter, targetCharacter: GameCharacter) {
        self.activeTeam = activeTeam
        self.targetTeam = targetTeam
        self.activeCharacter = activeCharacter
        self.targetCharacter = targetCharacter
        self.healthPoint =  activeCharacter.weapon.power
        if activeCharacter is Magus {
            self.actionType = ActionType.heal
        } else {
            self.actionType = ActionType.attack
        }
    }
    
    public func playRound() -> Round.ActionStatus {
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
public class Game {
    public var teams: [Team]
    public var rounds: [Round]
    private static let nbMaxTeam: Int = 2
    public var isOver: Bool {
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
    
    public var isFirstRound: Bool {
        if getLastRound() == nil {
            return true
        }
        return false
    }
    
    public func addRound(round: Round) {
        rounds.append(round)
    }
    
    public func addTeam(team: Team) {
        teams.append(team)
    }
    
    public func findWinner() -> Team? {
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
    
    public func getLastCreatedTeam() -> Team {
        return teams[teams.count - 1]
    }
    
    public func getActiveTeam() -> Team {
        // TODO: Relire dans le cour la comparaison d'objet pour éviter d'aller chercher le nom du joueur.
        var activeTeam: Team = teams[0]
        if !isFirstRound {
            for team in teams {
                if team.player != getLastRound()!.activeTeam.player {
                    activeTeam = team
                }
            }
        }
        return activeTeam
    }
    
    public func getInactiveTeam() -> Team {
        // TODO: Relire dans le cour la comparaison d'objet pour éviter d'aller chercher le nom du joueur.
        var inactiveTeam: Team = teams[1]
        if !isFirstRound {
            for team in teams {
                if team.player == getLastRound()!.activeTeam.player {
                    inactiveTeam = team
                }
            }
        }
        return inactiveTeam
    }
    
    public func getLastRound() -> Round? {
        guard rounds.count > 0 else {
            return nil
        }
        return rounds[rounds.count - 1]
    }
    
    public func isChestAvailable() -> Bool {
        // TODO: Mis en commentaire pour les tests.
        /*
        if Int(arc4random_uniform(UInt32(2))) > 0 {
            return true
        } else {
            return false
        }
         */
        return true
    }
    
    public func openChest()-> Weapon {
        return Weapon.createRandom()
    }
}

//==================================================
// MARK: - View
//==================================================
// MARK: - Display
public class Display {
    private let interfaceLineLength: Int = 70
    private let gameTitle: String = "Le choc des brutes"
    
    public init() {
        clearScreen()
    }
    
    // MARK: Draw and Speak Methods
    public func sayWelcome() {
        drawFrameOneLine(text: gameTitle)
    }
    
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
    
    public func drawFrameOneLineWithTitle(text: String, title: String) {
        drawLine(motif: "-")
        center(text: title)
        drawLine(motif: " ")
        center(text: text)
        drawLine(motif: " ")
        drawLine(motif: "-")
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
        allignLeft(lines: lines)
        drawLine(motif: " ")
        drawLine(motif: "-")
    }
    
    public func drawFrameMultiLines(lines: [String]) {
        drawLine(motif: "-")
        drawLine(motif: " ")
        allignLeft(lines: lines)
        drawLine(motif: " ")
        drawLine(motif: "-")
    }
    
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
    
    public enum gmMood: String {
        case normal = "🧐"
        case error = "😡"
    }
    
    public func gmSpeak(text: String, mood: gmMood) {
        print("\(mood.rawValue) \(text)")
    }
    
    public func showCharactersTypes() {
        var lines = [String]()
        lines.append("1-🤺 Combatant: Épée à la main, il incarne la polyvalence au combat.")
        lines.append("2-🧙🏻‍♂️ Mage     : Avec son baton il soigne les blessures de son équipe.")
        lines.append("3-👨🏻‍🚀 Colosse  : Protégé derrière son bouclier il est très résistant.")
        lines.append("4-💂🏻‍♂️ Nain     : Une hache à la main il est un tueur né.")
        drawFrameMultiLines(lines: lines)
    }
    
    public func formatText(text: String, maxLength: Int) -> String {
        var formatText: String = text
        while formatText.count < maxLength {
            formatText += " "
        }
        return formatText
    }
    
    // MARK: Read Methods
    // TODO: Ici clairement le else ne sert à rien mais j'arrive pas à l'enlever.
    public func readString() -> String{
        // Utiliser un guard pour le premier IF.
        if let playerResponse = readLine() {
            //isAusableStrin -> not empty string
            guard isUsableString(text: playerResponse) else {
                gmSpeak(text: "ERREUR: Le maitre du jeu apprécierait une réponse.", mood: Display.gmMood.error)
                return readString()
            }
            guard isGoodLenghtString(text: playerResponse) else {
                gmSpeak(text: "ERREUR: On écris pas de roman hein!! 10 caractères c'est suffisant!", mood: Display.gmMood.error)
                return readString()
            }
            return playerResponse
        } else {
            gmSpeak(text: "ERREUR: Le maitre du jeu apprécierait une réponse.", mood: Display.gmMood.error)
            return readString()
        }
    }
    
    public func readStringBetween(words: [String]) -> String {
        var playerResponse: String = readString()
        if !words.contains(playerResponse.uppercased()) {
            gmSpeak(text: "ERREUR: Tu dois choisir parmis : \(tableToString(words: words)).", mood: Display.gmMood.error)
            playerResponse = readStringBetween(words: words)
        }
        return playerResponse
    }
    
    private func tableToString(words: [String]) -> String {
        var list: String = ""
        for word in words {
            list += " \(word.lowercased())"
        }
        return list
    }
    
    // TODO: Utilisation d'expression régulière pour éviter les saisie de "" ou " " ou "     "...
    // chercher peut etre un meilleur nom
    private func isGoodLenghtString(text: String) -> Bool {
        guard text.count <= 10 else {
            return false
        }
        return true
    }
    
    private func isUsableString(text: String) -> Bool {
        guard text != "" && text != " " else {
            return false
        }
        return true
    }
    
    // TODO : utiliser guard.
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
        for _ in 1...40 {
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
public class MainController {
    private var game: Game
    private var startGameController: StartGameController
    private var fightController: FightController
    private var endGameController: EndGameController
    
    public init() {
        self.game = Game()
        // Etape 1.
        startGameController = StartGameController(game: game)
        // Etape 2.
        fightController = FightController(game: game)
        // Etape 3.
        endGameController = EndGameController(game: game)
    }
}

public class StartGameController {
    private var game: Game
    private var display: Display
    
    public init(game: Game) {
        self.display = Display()
        self.game = game
        createGame()
    }
    
    private func createGame() {
        while game.teams.count < 2 {
            createTeam()
            while game.getLastCreatedTeam().characters.count < 3 {
                var character: AnyObject
                character = createCharacter(playerName: game.getLastCreatedTeam().player)
                game.getLastCreatedTeam().addCharacter(character: character)
            }
        }
    }
    
    private func createTeam() {
        display.clearAndTitle()
        let playerName: String = askPlayerName()
        game.addTeam(team: Team(player: playerName))
    }
    
    private func askPlayerName() -> String {
        display.gmSpeak(text: "Nom Joueur : ", mood: Display.gmMood.normal)
        var playerName: String = display.readString()
        if getAllPlayersNames().contains(playerName.uppercased()) {
            display.gmSpeak(text: "ERREUR: Nom déja pris.", mood: Display.gmMood.error)
            playerName = askPlayerName()
        }
        return playerName
    }
    
    private func createCharacter(playerName: String) ->AnyObject {
        display.clearAndTitle()
        showTeam(team: game.getLastCreatedTeam())
        let characterName: String = askCharacterName()
        display.clearAndTitle()
        showTeam(team: game.getLastCreatedTeam())
        let characterType: Int = askCharacterType(characterName: characterName)
        return buildCharacter(characterName: characterName, characterType: characterType)
    }
    
    // Renvoyer GameCharacters (pas que ici mais en général
    private func buildCharacter(characterName: String, characterType: Int) -> AnyObject {
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
            return Fighter(name: characterName)
        }
    }
    
    private func askCharacterName() -> String {
        display.gmSpeak(text: "Choisis le nom de ton personnage :", mood: Display.gmMood.normal)
        var characterName: String = display.readString()
        if getAllCharactersNames().contains(characterName.uppercased()) {
            display.gmSpeak(text: "ERREUR: Un personnage porte déja le même nom.", mood: Display.gmMood.error)
            characterName = askCharacterName()
        }
        return characterName
    }
    
    private func askCharacterType(characterName: String) -> Int {
        display.showCharactersTypes()
        display.gmSpeak(text: "Choisis la classe de \(characterName) :", mood: Display.gmMood.normal)
        return display.readIntBetween(min: 1, max: 4)
    }
    
    private func getAllCharactersNames() -> [String] {
        var allCharactersNames = [String]()
        for team in game.teams {
            for character in team.characters {
                allCharactersNames.append(((character as! GameCharacter).name).uppercased())
            }
        }
        return allCharactersNames
    }
    
    private func getAllPlayersNames() -> [String] {
        var allPlayersNames = [String]()
        for team in game.teams {
            allPlayersNames.append(team.player.uppercased())
        }
        return allPlayersNames
    }
    
    // TODO: Ces fonction sont en double avec celle IDENTIQUES de la classe FightsController.
    // TODO: Peut être faire une classe Controller mère qui contiendrai ces fontion d'affichage des équipes? Ou faire un DisplayController ?
    // TODO: Peut etre que l'héritage est pas mal ça permettrais de réécrire la méthode showTeam pour ajouter "En attente de recrutement".
    private func showTeam(team: Team) {
        var lines = [String]()
        for character in team.characters {
            lines.append(characterInfo(character: character))
        }
        while lines.count < 3 {
            lines.append("📜 En attente de recrutement.")
        }
        display.drawFrameMultiLinesWithTitle(lines: lines, title: team.player)
    }
    
    private func characterInfo(character: AnyObject) -> String {
        let characterName: String = display.formatText(text: ((character as! GameCharacter).name), maxLength: 10)
        let characterWeapon: String = (character as! GameCharacter).weapon.name
        let characterPower: String = getAttackOrHealIcon(character: character) + display.formatText(text: (String((character as! GameCharacter).weapon.power)), maxLength: 4)
        var characterHealth: String = "   "
        var lifeIcon: String = "☠️ "
        if (character as! GameCharacter).isAlive {
            characterHealth = display.formatText(text: (String((character as! GameCharacter).health)), maxLength: 4)
            lifeIcon = "❤️"
        }
        return "\(getCharacterTypeIcon(character: character)) \(characterName) \(lifeIcon) \(characterHealth) \(characterPower) \(characterWeapon)"
    }
    
    private func getCharacterTypeIcon(character: AnyObject) -> String {
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
    
    private func getAttackOrHealIcon(character: AnyObject) -> String {
        var icon: String = "⚔️ "
        if character is Magus {
            icon = "🌡 "
        }
        return icon
    }
}

public class FightController {
    private var game: Game
    private var display: Display
    
    public init(game: Game) {
        self.display = Display()
        self.game = game
        while !game.isOver {
            game.addRound(round: createRound(error: ""))
        }
    }
    
    // TODO: Factoriser
    private func createRound(error: String) -> Round {
        let activeTeam: Team = game.getActiveTeam()
        findChest(activeTeam: activeTeam)
        showInterface()
        showError(error: error)
        let activeCharacter: AnyObject = askActiveCharacter(activeTeam: activeTeam)
        showInterface()
        let targetCharacter: AnyObject = askTargetCharacter(activeTeam: activeTeam, activeCharacter: activeCharacter)
        let targetTeam: Team = getTargetTeam(activeTeam: activeTeam, activeCharacter: activeCharacter)
        let round: Round = Round(activeTeam: activeTeam, targetTeam: targetTeam, activeCharacter: (activeCharacter as! GameCharacter), targetCharacter: (targetCharacter as! GameCharacter))
        if round.playRound() == Round.ActionStatus.noError {
            return round
        } else {
            return createRound(error: "Tour annulé, recomence le tour.")
        }
    }
    
    // TODO: Factoriser
    private func findChest(activeTeam: Team) {
        if game.isChestAvailable() {
            let weapon: Weapon = game.openChest()
            let characters = activeTeam.getCharacterCanEquip(weapon: weapon)
            var charactersNames = activeTeam.getCharactersNamesCanEquip(weapon: weapon)
            if characters.count > 0 {
                display.clearAndTitle()
                display.drawFrameOneLineWithTitle(text: "\(getWeaponIcon(weapon: weapon))\(weapon.power) : \(weapon.name)", title: "Coffre au trésor")
                showSelected(characters: characters)
                charactersNames.append("NON")
                if characters.count == 1 {
                    charactersNames.append("OUI")
                    display.gmSpeak(text: "Equiper l'arme ? :", mood: Display.gmMood.normal)
                } else {
                    display.gmSpeak(text: "Sur qui équiper l'arme ? (tape non detruire l'arme):", mood: Display.gmMood.normal)
                }
                var playerResponse: String = display.readStringBetween(words: charactersNames)
                if playerResponse.uppercased() != "NON" {
                    if playerResponse.uppercased() == "OUI" {
                        playerResponse = characters[0].name
                    }
                    let character = activeTeam.getCharacter(name: playerResponse)
                    (character as! GameCharacter).equip(weapon: weapon)
                }
            }
        }
    }
    
    private func getWeaponIcon(weapon: Weapon) -> String {
        var icon: String = "⚔️ "
        if weapon.category == Weapon.Category.stick {
            icon = "🌡 "
        }
        return icon
    }
    
    private func showSelected(characters: [GameCharacter]) {
        var lines = [String]()
        for character in characters {
            lines.append(characterInfo(character: character))
        }
        display.drawFrameMultiLines(lines: lines)
    }
    
    private func showInterface() {
        display.clearAndTitle()
        showLastRound()
        showTeams()
    }
    
    private func showError(error: String) {
        if error != "" {
            display.gmSpeak(text: "ERREUR: \(error):", mood: Display.gmMood.error)
        }
    }
    
    private func getTargetTeam(activeTeam: Team, activeCharacter: AnyObject) -> Team {
        var targetTeam: Team
        if activeCharacter is Magus {
            targetTeam = activeTeam
        } else {
            targetTeam = game.getInactiveTeam()
        }
        return targetTeam
    }
    
    // TODO: A FACTORISER peut etre avec un nom genre autoSelect.
    // TODO: A expliquer a l'utilisateur.
    private func askTargetCharacter(activeTeam: Team, activeCharacter: AnyObject) -> AnyObject {
        if activeCharacter is Magus {
            if activeTeam.countCharacterAlive() == 1 {
                return activeCharacter
            } else {
                display.gmSpeak(text: "Choisis la cible de \((activeCharacter as! GameCharacter).name):", mood: Display.gmMood.normal)
                return activeTeam.getCharacter(name: display.readStringBetween(words: activeTeam.getCharactersAliveNames()))
            }
        } else {
            let targetTeam: Team = game.getInactiveTeam()
            if targetTeam.countCharacterAlive() == 1 {
                return targetTeam.getCharacter(name: targetTeam.getCharactersAliveNames()[0])
            } else {
                display.gmSpeak(text: "Choisis la cible de \((activeCharacter as! GameCharacter).name):", mood: Display.gmMood.normal)
                return targetTeam.getCharacter(name: display.readStringBetween(words: targetTeam.getCharactersAliveNames()))
            }
        }
    }
    
    private func askActiveCharacter(activeTeam: Team) -> AnyObject {
        if activeTeam.countCharacterAlive() == 1 {
            return activeTeam.getCharacter(name: activeTeam.getCharactersAliveNames()[0])
        } else {
            display.gmSpeak(text: "\(activeTeam.player), choisis avec quel personnage tu vas jouer ce tour :", mood: Display.gmMood.normal)
            return activeTeam.getCharacter(name: display.readStringBetween(words: activeTeam.getCharactersAliveNames()))
        }
    }
    
    private func showLastRound() {
        if !game.isFirstRound {
            let lastRound: Round = game.getLastRound()!
            display.drawFrameOneLineWithTitle(text: "\(lastRound.activeCharacter.name) \(getAttackOrHealIcon(character: lastRound.activeCharacter)) \(lastRound.healthPoint) \(lastRound.targetCharacter.name)", title: "Récap'")
        }
        
    }
    
    private func showTeams() {
        for team in game.teams {
            showTeam(team: team)
        }
    }
    
    // TODO: Ces fonction sont en double avec celle IDENTIQUES de la classe StartGameController lire les commentaires dans StartGameController.
    private func showTeam(team: Team) {
        var lines = [String]()
        for character in team.characters {
            lines.append(characterInfo(character: character))
        }
        while lines.count < 3 {
            lines.append("📜 En attente de recrutement.")
        }
        display.drawFrameMultiLinesWithTitle(lines: lines, title: team.player)
    }
    
    private func characterInfo(character: AnyObject) -> String {
        let characterName: String = display.formatText(text: ((character as! GameCharacter).name), maxLength: 10)
        let characterWeapon: String = (character as! GameCharacter).weapon.name
        let characterPower: String = getAttackOrHealIcon(character: character) + display.formatText(text: (String((character as! GameCharacter).weapon.power)), maxLength: 4)
        var characterHealth: String = "   "
        var lifeIcon: String = "☠️ "
        if (character as! GameCharacter).isAlive {
            characterHealth = display.formatText(text: (String((character as! GameCharacter).health)), maxLength: 4)
            lifeIcon = "❤️"
        }
        return "\(getCharacterTypeIcon(character: character)) \(characterName) \(lifeIcon) \(characterHealth) \(characterPower) \(characterWeapon)"
    }
    
    private func getCharacterTypeIcon(character: AnyObject) -> String {
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
    
    private func getAttackOrHealIcon(character: AnyObject) -> String {
        var icon: String = "⚔️ "
        if character is Magus {
            icon = "🌡 "
        }
        return icon
    }
}

public class EndGameController {
    private var game: Game
    private var display: Display
    
    public init(game: Game) {
        self.display = Display()
        self.game = game
        print("Félicitation : \(game.findWinner()!.player), tu as gagné.")
        // TODO: clearAndTitle
        // TODO: Affichage des score par équipe.
        // TODO: Félicité le vainqueur.
    }
}

//==================================================
// MARK: - Main
//==================================================
var mainGameController: MainController = MainController()
