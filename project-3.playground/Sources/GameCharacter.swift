public class GameCharacter {
    //===============================
    // MARK: - Stored Properties
    //===============================
    public let name: String
    public var health: Int
    public var weapon: Weapon
    //===============================
    // MARK: - Public Methods
    //===============================
    public init(name: String) {
        self.name = name
        health = 0
        weapon = GameCharacter.createBaseWeapon()
    }
    //===============================
    // MARK: Private Methods
    //===============================
    private static func createBaseWeapon()-> Weapon {
        return Weapon(category: Weapon.Category.sword, material: Weapon.Material.wood)
    }
}

/*
 Utilisé proprieté calculer pour la santé. (dans les classes filles) pour éviter le overheal et le over damage.
 pas plus de point de vie que ne le permet la classe du personnage.
 pas de point de vie en dessous de 0.
 
 
 
 */
