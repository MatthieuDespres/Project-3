public class Magus: GameCharacter {
    //===============================
    // MARK: - Public Methods
    //===============================
    public override init(name: String) {
        super.init(name: name)
        health = 50
        weapon = Magus.createBaseWeapon()
    }
    public func heal(target: GameCharacter) {
        // TODO: - Write code
        /*Need to check :
         * 1 - Do no overheal i cant heal 50 if char need 10. i heal just 10hp.
         * 2 - I cant heal a death char.
         */
    }
    //===============================
    // MARK: Private Methods
    //===============================
    private static func createBaseWeapon()-> Weapon {
        return Weapon(category: Weapon.Category.stick, material: Weapon.Material.wood)
    }
}
