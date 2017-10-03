public class Warrior: GameCharacter {
    //===============================
    // MARK: - Public Methods
    //===============================
    public func attack(target: GameCharacter) {
        if target.isAlive && (target.name != name) {
            target.health -= getDamagePoint(target: target)
        }
    }
    //===============================
    // MARK: Private Methods
    //===============================
    private func getDamagePoint(target: GameCharacter)-> Int{
        if (target.health - weapon.power) >= 0 {
            return weapon.power
        } else {
            return target.health
        }
    }
}
