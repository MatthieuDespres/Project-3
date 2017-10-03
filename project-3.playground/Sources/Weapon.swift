import Foundation
public class Weapon {
    //===============================
    // MARK: - Stored properties
    //===============================
    private let weaponCategory: WeaponCategory
    private let weaponMaterial: WeaponMaterial
    private let weaponTotem: WeaponTotem
    
    //===============================
    // MARK: - Calculated properties
    //===============================
    // Calculate the power of the weapon according to its material and its category.
    public var power: Int {
        var power: Int = 0
        switch weaponCategory {
        case .sword:
            power = 10
        case .stick:
            power = 20
        case .shield:
            power = 5
        case .ax:
            power = 20
        }
        switch weaponMaterial {
        case .wood:
            power += 0
        case .iron:
            power += 5
        case .diamond:
            power += 10
        }
        return power
    }
    // Generate weapon name considering weapon properties.
    public var name: String {
        return "\(weaponCategory.rawValue) \(weaponMaterial.rawValue) \(weaponTotem.rawValue)"
    }
    
    //===============================
    // MARK: - Enumeration
    //===============================
    /* If I want to create new totem :
     * 1- Create a new enum case.
     * 2- Add correspondig case on the switch.
     * 3- Add 1 to the constant "nbDifferentTotems".
     */
    private enum WeaponTotem: String {
        case owl = "de la chouette"
        case panda = "du panda"
        case weasel = "de la belette"
        case mongoose = "de la mangouste"
        case rat = "du rat"
        case eagle = "de l'aigle"
        case pony = "du poney"
        case doowy = "de Doowy l'oeuvre d'art"
        
        // Gives a random totem.
        static func randomTotem() -> WeaponTotem {
            let nbDifferentTotems: Int = 8
            let indexTotem: Int = Int(arc4random_uniform(UInt32(nbDifferentTotems)))
            switch indexTotem {
            case 1:
                return .owl
            case 2:
                return .panda
            case 3:
                return .weasel
            case 4:
                return .mongoose
            case 5:
                return .rat
            case 6:
                return .eagle
            case 7:
                return.pony
            case 8:
                return .doowy
            default:
                return .doowy
            }
        }
    }
    
    //===============================
    // MARK: - Methods
    //===============================
    public init(weaponCategory: WeaponCategory, weaponMaterial: WeaponMaterial) {
        self.weaponCategory = weaponCategory
        self.weaponMaterial = weaponMaterial
        self.weaponTotem = WeaponTotem.randomTotem()
    }
}
