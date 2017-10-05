import Foundation
public class Round {
    //===============================
    // MARK: - Stored Properties
    //===============================
    private let activeTeam: Team
    private let targetTeam: Team
    private var activeCharacter: GameCharacter
    private var targetCharacter: GameCharacter
    private let actionType: ActionType
    private let healthPoint: Int
    //===============================
    // MARK: Calculated Properties
    //===============================
    private var isTeamMate: Bool {
        return checkPlayersName()
    }
    //===============================
    // MARK: - Enumeration
    //===============================
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
    //===============================
    // MARK: - Public Methods
    //===============================
    public init(activeTeam: Team, targetTeam: Team, activeCharacter: GameCharacter, targetCharacter: GameCharacter, actionType: ActionType) {
        self.activeTeam = activeTeam
        self.targetTeam = targetTeam
        self.activeCharacter = activeCharacter
        self.targetCharacter = targetCharacter
        self.actionType = actionType
        self.healthPoint =  activeCharacter.weapon.power
    }
    public func executeAction()-> Round.ActionStatus {
        switch actionType {
        case Round.ActionType.attack:
            return attack()
        case Round.ActionType.heal:
            return heal()
        }
    }
    //===============================
    // MARK: Private Methods
    //===============================
    private func checkPlayersName()-> Bool {
        if activeTeam.player == targetTeam.player {
            return true
        } else {
            return false
        }
    }
    private func lookForChest()-> Bool {
        if Int(arc4random_uniform(UInt32(2))) > 0 {
            return true
        } else {
            return false
        }
    }
    private func openChest()-> Weapon {
        return Weapon.createRandom()
    }
    //===============================
    // TODO: A SIMPLIFIER LES 2 FONCTIONS
    //===============================
    private func attack()-> Round.ActionStatus {
        if !isTeamMate {
            if activeCharacter is Warrior {
                return (activeCharacter as! Warrior).attack(target: targetCharacter)
            } else {
                return Round.ActionStatus.magusAttackError
            }
        } else {
            return Round.ActionStatus.attackTeamMateError
        }
    }
    private func heal()-> Round.ActionStatus {
        if isTeamMate {
            if activeCharacter is Magus {
                return (activeCharacter as! Magus).heal(target: targetCharacter)
            } else {
                return Round.ActionStatus.warriorHealError
            }
        } else {
            return Round.ActionStatus.healEnemyError
        }
    }
}
