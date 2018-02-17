public class GameCharacter {
    // MARK: - Stored Properties
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
    // MARK: - Enumeration
    public enum Job: String {
        case fighter = "combatant"
        case magus = "mage"
        case colossus = "colosse"
        case dwarf = "nain"
    }
    // MARK: - Public Methods
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
    // MARK: Private Methods
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
}
