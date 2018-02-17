// MARK: - Importations
import Foundation


// MARK: - Teams creator (Surement dans la classe Game)
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
        display.drawSimpleLine()
        display.clearScreen()
    }
}
// MARK: - Characters creator (Surement dans la classe Game)
func createCharacters(numPlayer: Int, playerName: String) {
    print(playerName + " il est temps de constituer ton équipe.")
    var nbCharacters: Int = 0
    while nbCharacters < 3 {
        showCharactersTypes()
        //Personnalisé la phrase serais cool
        print("Fais ton choix :")
        if let charactereNumber = readLine() {
            switch charactereNumber {
            case "1":
                print("Tu as choisis un combatant.")
                //Crée obj et ajouter a une collec
            case "2":
                print("Tu as choisis un mage.")
                //Crée obj et ajouter a une collec
            case "3":
                print("Tu as choisis un colosse")
                //Crée obj et ajouter a une collec
            case "4":
                print("Tu as choisis un nain.")
                //Crée obj et ajouter a une collec
            default:
                print("Quand on choisis mal on a un combatant.")
                //Crée obj et ajouter a une collec
            }
        }
        nbCharacters += 1
    }
}
// Pourquoi pas en méthode static dans GameCharacters? mais c'est de l'affichange dans un class non dédié à ça.
func showCharactersTypes() {
    print(" 1 - Combatant : 100 PV : Épée à la main, il incarne la polyvalence au combat.")
    print(" 2 - Mage : 50 PV : Équipé d'un baton il soigne les blessures de son équipe.")
    print(" 3 - Colosse : 200 PV : Protégé derrière son bouclier il est incroyablement résistant.")
    print(" 4 - Nain : 50 PV : Sa hache couplé à sa brutalitée fait du nain un tueur effroyable.")
}






public class Display {
    // MARK: - Stored Properties
    private let interfaceLineLength: Int = 60
    // MARK: - Methods
    public init(welcomeWord: String) {
        sayWelcome(welcomeWord: welcomeWord)
    }
    private func sayWelcome(welcomeWord: String) {
        drawFrameOneText(text: welcomeWord)
    }
    public func clearScreen() {
        for _ in 1...20 {
            print("\n")
        }
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
}







// MARK: - The Game
var display: Display
display = Display(welcomeWord: "Le choc des brutes")
createTeams()
