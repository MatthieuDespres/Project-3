public class Colossus: Warrior {
    //===============================
    // MARK: - Stored Properties
    //===============================
    private static let colossusHealthMax: Int = 200
    //===============================
    // MARK: - Public Methods
    //===============================
    public override init(name: String) {
        super.init(name: name)
        health = Colossus.colossusHealthMax
        healthMax = Colossus.colossusHealthMax
        weapon = Colossus.createBaseWeapon()
    }
    //===============================
    // MARK: Private Methods
    //===============================
    private static func createBaseWeapon()-> Weapon {
        return Weapon(category: Weapon.Category.shield, material: Weapon.Material.wood)
    }
}
