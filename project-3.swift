// MARK: - Importations
import Foundation
// MARK: - Global constant
let interfaceLineLength: Int = 60
// MARK: - Interface functions
// MARK: Welcome words
func sayWelcome () {
    let welcomeWord: String = "Le choc des brutes"
    frameOneText(text: welcomeWord)
}
// MARK: Clear screen
func clearScreen() {
    for _ in 1...20 {
        print("\n")
    }
}
// MARK: Lines and frame
func simpleLine() {
    let lineLength: Int = interfaceLineLength
    var line: String = "+"
    for _ in 1...lineLength {
        line += "-"
    }
    line += "+"
    print(line)
}
func doubleLine() {
    let lineLength: Int = interfaceLineLength
    var line: String = "+"
    for _ in 1...lineLength {
        line += "="
    }
    line += "+"
    print(line)
}
func emptyLine() {
    let lineLength: Int = interfaceLineLength
    var line: String = "|"
    for _ in 1...lineLength {
        line += " "
    }
    line += "|"
    print(line)
}
func textLine(text: String) {
    let nbChar: Int = text.count
    let lineLength: Int = interfaceLineLength
    let prefix: Int = (lineLength - nbChar) / 2
    let suffix: Int = (lineLength - nbChar - prefix)
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
func frameOneText(text: String) {
    simpleLine()
    emptyLine()
    textLine(text: text)
    emptyLine()
    simpleLine()
}
// MARK: - Teams creator
func createTeams() {
    var numPlayer: Int = 1
    while numPlayer <= 2 {
        print("Nom Joueur \(numPlayer) : ")
        if var playerName = readLine() {
            // TODO: A FAIRE : Utilisation de Guard
            if playerName == "" {
                playerName = "Joueur \(numPlayer)"
            }
            createCharacters(numPlayer: numPlayer, playerName: playerName)
        }
        numPlayer += 1
        simpleLine()
        clearScreen()
    }
}
// MARK: - Characters creator
func createCharacters(numPlayer: Int, playerName: String) {
    print(playerName + " il est temps de constituer ton équipe.\nChoisis ton premier personnage.")
    showCharactersTypes()
}
func showCharactersTypes() {
    print(" 1 - Combatant : 100 PV : Épée à la main, il incarne la polyvalence au combat.")
    print(" 2 - Mage : 50 PV : Équipé d'un baton il soigne les blessures de son équipe.")
    print(" 3 - Colosse : 200 PV : Protégé derrière son bouclier il est incroyablement résistant.")
    print(" 4 - Nain : 50 PV : Sa hache couplé à sa brutalitée fait du nain un tueur effroyable.")
}
// MARK: - The Game
clearScreen()
sayWelcome()
createTeams()

