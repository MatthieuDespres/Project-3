import Foundation
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
