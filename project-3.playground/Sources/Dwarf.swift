public class Dwarf: Warrior {
    //===============================
    // MARK: - Stored Properties
    //===============================
    private static let dwarfHealthMax: Int = 50
    //===============================
    // MARK: - Public Methods
    //===============================
    public override init(name: String) {
        super.init(name: name)
        health = Dwarf.dwarfHealthMax
        healthMax = Dwarf.dwarfHealthMax
        weapon = Dwarf.createBaseWeapon()
    }
    //===============================
    // MARK: Private Methods
    //===============================
    private static func createBaseWeapon()-> Weapon {
        return Weapon(category: Weapon.Category.ax, material: Weapon.Material.wood)
    }
}
