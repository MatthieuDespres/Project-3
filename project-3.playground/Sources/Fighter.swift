public class Fighter: Warrior {
    //===============================
    // MARK: - Stored Properties
    //===============================
    private static let fighterHealthMax: Int = 100
    //===============================
    // MARK: - Public Methods
    //===============================
    public override init(name: String) {
        super.init(name: name)
        health = Fighter.fighterHealthMax
        healthMax = Fighter.fighterHealthMax
        weapon = Fighter.createBaseWeapon()
    }
    //===============================
    // MARK: Private Methods
    //===============================
    private static func createBaseWeapon()-> Weapon {
        return Weapon(category: Weapon.Category.sword, material: Weapon.Material.wood)
    }
}
