// MARK: - Importations
import PlaygroundSupport
// MARK: - Function for tests
func createTeam1()-> Team {
    var mage: Magus
    mage = Magus(name: "Mage")
    var combatant: Fighter
    combatant = Fighter(name: "Combatant")
    var colosse: Colossus
    colosse = Colossus(name: "Colosse")
    var tableauEquipe = [AnyObject]()
    tableauEquipe.append(mage)
    tableauEquipe.append(combatant)
    tableauEquipe.append(colosse)
    return Team(player: "Equipe 1", characters: tableauEquipe)
}
func createTeam2()-> Team {
    var mage: Magus
    mage = Magus(name: "Mage 2")
    var combatant: Fighter
    combatant = Fighter(name: "Combatant 2")
    var colosse: Colossus
    colosse = Colossus(name: "Colosse 2")
    var tableauEquipe = [AnyObject]()
    tableauEquipe.append(mage)
    tableauEquipe.append(combatant)
    tableauEquipe.append(colosse)
    return Team(player: "Equipe 2", characters: tableauEquipe)
}
func afficherScore(equipe1: Team, equipe2: Team) {
    afficheScoreEquipe(equipe: equipe1)
    retourLignes(nbLignes: 1)
    afficheScoreEquipe(equipe: equipe2)
    retourLignes(nbLignes: 1)
}
func afficheScoreEquipe(equipe: Team) {
    print(equipe.player)
    for character in equipe.characters {
        print((character as! GameCharacter).name)
        print((character as! GameCharacter).health)
    }
}
func retourLignes (nbLignes: Int) {
    var ligne: Int = 0
    while ligne < nbLignes {
        print("\n")
        ligne += 1
    }
}
// MARK: - Tests
//Création des deux équipes.
var equipe1 = createTeam1()
var equipe2 = createTeam2()
//Affichage des scores.
afficherScore(equipe1: equipe1, equipe2: equipe2)

var round1: Round
round1 = Round(activeTeam: equipe1, targetTeam: equipe2, activeCharacter: (equipe1.characters[1] as! GameCharacter), targetCharacter: (equipe2.characters[0] as! GameCharacter), actionType: Round.ActionType.attack)
round1.executeAction()
afficherScore(equipe1: equipe1, equipe2: equipe2)

var round2: Round
round2 = Round(activeTeam: equipe2, targetTeam: equipe2, activeCharacter: (equipe2.characters[0] as! GameCharacter), targetCharacter: (equipe2.characters[0] as! GameCharacter), actionType: Round.ActionType.heal)
round2.executeAction()
afficherScore(equipe1: equipe1, equipe2: equipe2)




// A FAIRE :
/*
 * Verrifier que le personage actif appartien bien a l'équipe active et que le personage ciblé appartien bien a l'équipe ciblé.(Classe game)
 */
