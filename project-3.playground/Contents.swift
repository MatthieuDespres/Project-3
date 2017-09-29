//Importation de foundration pour le random.
import Foundation


// Classe Weapon
// Portée : Interne(proprieté et méthodes sauf weaponTotem qui est privée) (par défaut dans swift donc je précise pas)
class Weapon {
    // Propriétés stockés.
    let weaponCategory: WeaponCategory
    let weaponMaterial: WeaponMaterial
    private let weaponTotem: WeaponTotem
    
    // Propriétés calculés.
    var power: Int {
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
    var name: String {
        return "\(weaponCategory.rawValue) \(weaponMaterial.rawValue) \(weaponTotem.rawValue)"
    }
    
    // Énumeration.
    private enum WeaponTotem: String {
        case owl = "de la chouette"
        case panda = "du panda"
        case weasel = "de la belette"
        case mongoose = "de la mangouste"
        case rat = "du rat"
        case eagle = "de l'aigle"
        case pony = "du poney"
        case doowy = "de Doowy l'oeuvre d'art"
        
        static func randomTotem() -> WeaponTotem {
            let indexTotem: Int = Int(arc4random_uniform(UInt32(8)))
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
    
    // Méthodes.
    init(weaponCategory: WeaponCategory, weaponMaterial: WeaponMaterial) {
        self.weaponCategory = weaponCategory
        self.weaponMaterial = weaponMaterial
        self.weaponTotem = WeaponTotem.randomTotem()
    }
}

// Énumerations interne au module.(réglage par défaut dans swift donc pas de précision supplémentaires
enum WeaponCategory: String {
    case sword = "Épée"
    case stick = "Bâton"
    case shield = "Bouclier"
    case ax = "Hache"
}
enum WeaponMaterial: String {
    case wood = "en bois"
    case iron = "de fer"
    case diamond = "de diamant"
}


//Tests
var arme: Weapon
arme = Weapon(weaponCategory: WeaponCategory.sword, weaponMaterial: WeaponMaterial.wood)
arme.name
arme.power
