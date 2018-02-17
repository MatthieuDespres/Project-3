public class Warrior: GameCharacter {
    // MARK: - Public Methods
    public func attack(target: GameCharacter)-> Round.ActionStatus {
        if target.isAlive {
            target.health -= getDamagePoint(target: target)
            return Round.ActionStatus.noError
        } else {
            return Round.ActionStatus.attackDeadError
        }
    }
    // MARK: Private Methods
    private func getDamagePoint(target: GameCharacter) -> Int{
        if (target.health - weapon.power) >= 0 {
            return weapon.power
        } else {
            return target.health
        }
    }
}
