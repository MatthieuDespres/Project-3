public class GameCharacter {
    //===============================
    // MARK: - Stored Properties
    //===============================
    public let name: String
    public var health: Int
    public var weapon: Weapon
    //===============================
    // MARK: Calculated Properties
    //===============================
    //===============================
    // MARK: - Enumeration
    //===============================
    //===============================
    // MARK: - Public Methods
    //===============================
    public init(name: String) {
        self.name = name
        health = 0
        weapon = Weapon(category: Weapon.Category.sword, material: Weapon.Material.wood)
    }
    //===============================
    // MARK: Private Methods
    //===============================
}
