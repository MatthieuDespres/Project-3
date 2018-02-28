// TODO: Retirer tout les TODO.
// TODO: Chercher les méthodes inutilisé.
// TODO: Quand cela arrive , expliquer au joueur qu'on a automatiquement choisis le personage actif et ou le personnage cible.
// TODO: Dans le récap, ne pas afficher les points de dégats de l'arme du personnage mais les dégats réelement sbi ou soigné par la cible
// TODO: Si dans une équipe il ne reste qu'un mage, la partie est perdu ( du coup le score final ne sera pas de 3 à X mais de 2 à X
// TODO: Si l'arme trouvé est la meme que celle ou celles déja équiper ne pas proposer
// TODO: Faire comprendre que c'est léquipe 2 qui créer son équipe apriori c pas claire xav a eu l'idée des couleurs
// TODO: Faire des crédits a la fin du jeu.
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
    public var characters: [GameCharacter]
    public var nbCharacterAlive: Int {
        return countCharacterAlive()
    }
    
    public init(player: String) {
        self.player = player
        self.characters = [GameCharacter]()
    }
    
    public func countCharacterAlive() -> Int {
        var nbCharacterAlive: Int = 0
        for character in characters {
            if character.isAlive{
                nbCharacterAlive += 1
            }
        }
        return nbCharacterAlive
    }
    
    public func addCharacter(character: GameCharacter) {
        characters.append(character)
    }
    
    public func getCharacter(name: String) -> GameCharacter {
        var characterFind: GameCharacter = characters[0]
        for character in characters {
            if character.name.uppercased() == name.uppercased() {
                characterFind = character
            }
        }
        return characterFind
    }
    
    public func getCharactersAliveNames() -> [String] {
        var names = [String]()
        for character in characters {
            if character.isAlive {
                names.append(character.name.uppercased())
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
            if character.isAlive && character.checkUse(weapon: weapon) {
                characterCanEquip.append(character)
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
        if Int(arc4random_uniform(UInt32(2))) > 0 {
            return true
        } else {
            return false
        }
    }
    
    public func openChest()-> Weapon {
        return Weapon.createRandom()
    }
    
    public func calculateScore(team: Team) -> [String: Int] {
        var scores: [String: Int] = ["attack": 0, "heal": 0]
        for round in rounds {
            if team.player == round.activeTeam.player {
                switch round.actionType {
                case Round.ActionType.attack:
                    scores["attack"] = scores["attack"]! + round.healthPoint
                case Round.ActionType.heal:
                    scores["heal"] = scores["heal"]! + round.healthPoint
                }
            }
        }
        return scores
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
    
    // TODO: Utiliser des while pour échaper les bugs
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
        let suffix: Int = interfaceLineLength - text.count
        var lineText: String = text
        var nbEmpyChar: Int = 1
        while nbEmpyChar < suffix {
            lineText += " "
            nbEmpyChar += 1
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
    public func readString() -> String{
        guard let playerResponse = readLine() else {
            gmSpeak(text: "ERREUR: Le maitre du jeu apprécierait une réponse.", mood: Display.gmMood.error)
            return readString()
        }
        guard isNotEmpty(text: playerResponse) else {
            gmSpeak(text: "ERREUR: Le maitre du jeu apprécierait une réponse.", mood: Display.gmMood.error)
            return readString()
        }
        guard isGoodLenghtString(text: playerResponse) else {
            gmSpeak(text: "ERREUR: On écris pas de roman hein!! 10 caractères c'est suffisant!", mood: Display.gmMood.error)
            return readString()
        }
        return playerResponse
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
    
    private func isGoodLenghtString(text: String) -> Bool {
        guard text.count <= 10 else {
            return false
        }
        return true
    }
    
    private func isNotEmpty(text: String) -> Bool {
        guard text != "" && text != " " else {
            return false
        }
        return true
    }
    
    public func readInt() -> Int {
        guard let playerInt = Int(readString()) else {
            gmSpeak(text: "ERREUR: Ici la réponse appropriée est un nombre.", mood: Display.gmMood.error)
            return readInt()
        }
        return playerInt
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
        for _ in 1...60 {
            print("\n")
        }
    }
    
    public func clearAndTitle() {
        clearScreen()
        sayWelcome()
    }
    
    // TODO: Pour faire une pause c'est faisable ou c'est vraiment pas propre?
    public func littleBreak() {
        _ = readLine()
    }
}

//==================================================
// MARK: - Controller
//==================================================
public class MainController {
    private var game: Game = Game()
    private var startGameController: StartGameController
    private var fightController: FightController
    private var endGameController: EndGameController
    
    public init() {
        startGameController = StartGameController(game: game)
        fightController = FightController(game: game)
        endGameController = EndGameController(game: game)
    }
}

public class StartGameController: GameController {
    public override init(game: Game) {
        super.init(game: game)
        createGame()
    }
    
    private func createGame() {
        while game.teams.count < 2 {
            createTeam()
            while game.getLastCreatedTeam().characters.count < 3 {
                var character: GameCharacter
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
    
    private func createCharacter(playerName: String) -> GameCharacter {
        display.clearAndTitle()
        showTeam(team: game.getLastCreatedTeam())
        let characterName: String = askCharacterName()
        display.clearAndTitle()
        showTeam(team: game.getLastCreatedTeam())
        let characterType: Int = askCharacterType(characterName: characterName)
        return buildCharacter(characterName: characterName, characterType: characterType)
    }
    
    private func buildCharacter(characterName: String, characterType: Int) -> GameCharacter {
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
                allCharactersNames.append((character.name).uppercased())
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
    
    public override func showTeam(team: Team) {
        var lines = [String]()
        for character in team.characters {
            lines.append(characterInfo(character: character))
        }
        while lines.count < 3 {
            lines.append("📜 En attente de recrutement.")
        }
        display.drawFrameMultiLinesWithTitle(lines: lines, title: team.player)
    }
}

public class FightController: GameController {
    public override init(game: Game) {
        super.init(game: game)
        while !game.isOver {
            game.addRound(round: createRound(error: ""))
        }
    }
    
    private func createRound(error: String) -> Round {
        let activeTeam: Team = game.getActiveTeam()
        findChest(activeTeam: activeTeam)
        showInterface()
        showError(error: error)
        let activeCharacter: GameCharacter = askActiveCharacter(activeTeam: activeTeam)
        showInterface()
        let targetCharacter: GameCharacter = askTargetCharacter(activeTeam: activeTeam, activeCharacter: activeCharacter)
        let targetTeam: Team = getTargetTeam(activeTeam: activeTeam, activeCharacter: activeCharacter)
        let round: Round = Round(activeTeam: activeTeam, targetTeam: targetTeam, activeCharacter: activeCharacter, targetCharacter: targetCharacter)
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
                
                // One available.
                if characters.count == 1 {
                    charactersNames.append("OUI")
                    display.gmSpeak(text: "Equiper l'arme ? :", mood: Display.gmMood.normal)
                } else {
                    display.gmSpeak(text: "Sur qui équiper l'arme ? (tape non detruire l'arme):", mood: Display.gmMood.normal)
                }
                var playerResponse: String = display.readStringBetween(words: charactersNames)
                
                // Equip weapon
                if playerResponse.uppercased() != "NON" {
                    if playerResponse.uppercased() == "OUI" {
                        playerResponse = characters[0].name
                    }
                    let character = activeTeam.getCharacter(name: playerResponse)
                    character.equip(weapon: weapon)
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
    
    private func getTargetTeam(activeTeam: Team, activeCharacter: GameCharacter) -> Team {
        var targetTeam: Team
        if activeCharacter is Magus {
            targetTeam = activeTeam
        } else {
            targetTeam = game.getInactiveTeam()
        }
        return targetTeam
    }
    
    // TODO: A factoriser
    private func askTargetCharacter(activeTeam: Team, activeCharacter: GameCharacter) -> GameCharacter {
        if activeCharacter is Magus {
            if activeTeam.countCharacterAlive() == 1 {
                display.gmSpeak(text: "\(activeCharacter.name) est bien seul. Il soigne ses blessures.", mood: Display.gmMood.normal)
                display.littleBreak()
                return activeCharacter
            } else {
                display.gmSpeak(text: "Choisis la cible de \(activeCharacter.name):", mood: Display.gmMood.normal)
                return activeTeam.getCharacter(name: display.readStringBetween(words: activeTeam.getCharactersAliveNames()))
            }
        } else {
            let targetTeam: Team = game.getInactiveTeam()
            if targetTeam.countCharacterAlive() == 1 {
                let targetCharacter: GameCharacter = targetTeam.getCharacter(name: targetTeam.getCharactersAliveNames()[0])
                display.gmSpeak(text: "Il ne reste que \(targetCharacter.name) à abattre.", mood: Display.gmMood.normal)
                display.littleBreak()
                return targetCharacter
            } else {
                display.gmSpeak(text: "Choisis la cible de \(activeCharacter.name):", mood: Display.gmMood.normal)
                return targetTeam.getCharacter(name: display.readStringBetween(words: targetTeam.getCharactersAliveNames()))
            }
        }
    }
    
    // TODO: A factoriser
    private func askActiveCharacter(activeTeam: Team) -> GameCharacter {
        if activeTeam.countCharacterAlive() == 1 {
            let activeCharacter: GameCharacter = activeTeam.getCharacter(name: activeTeam.getCharactersAliveNames()[0])
            display.gmSpeak(text: "Tu n'as que \(activeCharacter.name) en vie.", mood: Display.gmMood.normal)
            display.littleBreak()
            return activeCharacter
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
}

public class EndGameController: GameController {
    public override init(game: Game) {
        super.init(game: game)
        display.clearAndTitle()
        showScores()
        display.gmSpeak(text: "Félicitation : \(game.findWinner()!.player), tu as gagné en \(game.rounds.count) tours avec un score de 3 kills à \((3 - game.findWinner()!.nbCharacterAlive)).\n\n", mood: Display.gmMood.normal)
    }
    
    private func showScores() {
        var scores: [String: Int] = ["attack": 0, "heal": 0]
        for team in game.teams {
            let teamScore = game.calculateScore(team: team)
            display.drawFrameOneLineWithTitle(text: "⚔️ \(teamScore["attack"]!) | 🌡 \(teamScore["heal"]!)", title: "Statistiques de l'équipe de \(team.player)")
            scores["attack"] = scores["attack"]! + teamScore["attack"]!
            scores["heal"] = scores["heal"]! + teamScore["heal"]!
        }
        display.drawFrameOneLineWithTitle(text: "⚔️ \(scores["attack"]!) | 🌡 \(scores["heal"]!)", title: "Statistiques globales")
    }
}

public class GameController {
    public var game: Game
    public var display: Display = Display()
    
    public init(game: Game) {
        self.game = game
    }
    
    public func showTeam(team: Team) {
        var lines = [String]()
        for character in team.characters {
            lines.append(characterInfo(character: character))
        }
        display.drawFrameMultiLinesWithTitle(lines: lines, title: team.player)
    }
    
    public func characterInfo(character: GameCharacter) -> String {
        let characterName: String = display.formatText(text: (character.name), maxLength: 10)
        let characterWeapon: String = character.weapon.name
        let characterPower: String = getAttackOrHealIcon(character: character) + display.formatText(text: (String(character.weapon.power)), maxLength: 4)
        var characterHealth: String = "   "
        var lifeIcon: String = "☠️ "
        if character.isAlive {
            characterHealth = display.formatText(text: (String(character.health)), maxLength: 4)
            lifeIcon = "❤️"
        }
        return "\(getCharacterTypeIcon(character: character)) \(characterName) \(lifeIcon) \(characterHealth) \(characterPower) \(characterWeapon)"
    }
    
    public func getCharacterTypeIcon(character: GameCharacter) -> String {
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
    
    public func getAttackOrHealIcon(character: GameCharacter) -> String {
        var icon: String = "⚔️ "
        if character is Magus {
            icon = "🌡 "
        }
        return icon
    }
}

//==================================================
// MARK: - Main
//==================================================
var mainGameController: MainController = MainController()
