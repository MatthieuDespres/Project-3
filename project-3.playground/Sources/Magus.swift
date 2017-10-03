public class Magus: GameCharacter {
    //===============================
    // MARK: - Stored Properties
    //===============================
    private static let magusHealthMax: Int = 50
    //===============================
    // MARK: - Public Methods
    //===============================
    public override init(name: String) {
        super.init(name: name)
        health = Magus.magusHealthMax
        healthMax = Magus.magusHealthMax
        weapon = Magus.createBaseWeapon()
    }
    public func heal(target: GameCharacter) {
        if target.isAlive {
            target.health += getHealPoint(target: target)
        }
    }
    //===============================
    // MARK: Private Methods
    //===============================
    private static func createBaseWeapon()-> Weapon {
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
