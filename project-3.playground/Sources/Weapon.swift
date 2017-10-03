import Foundation
public class Weapon {
    //===============================
    // MARK: - Stored Properties
    //===============================
    private let category: Category
    private let material: Material
    private let totem: Totem
    //===============================
    // MARK: Calculated Properties
    //===============================
    public var power: Int {
        return getCategoryPower() + getMaterialPower()
    }
    public var name: String {
        return "\(category.rawValue) \(material.rawValue) \(totem.rawValue)"
    }
    //===============================
    // MARK: - Enumeration
    //===============================
    public enum Category: String {
        case sword = "Épée"
        case stick = "Bâton"
        case shield = "Bouclier"
        case ax = "Hache"
    }
    public enum Material: String {
        case wood = "en bois"
        case iron = "de fer"
        case diamond = "de diamant"
    }
    private enum Totem: String {
        case owl = "de la chouette"
        case panda = "du panda"
        case weasel = "de la belette"
        case mongoose = "de la mangouste"
        case rat = "du rat"
        case eagle = "de l'aigle"
        case pony = "du poney"
        case doowy = "de Doowy l'oeuvre d'art"
        static var random: Totem{
            let totems = [Totem.owl, Totem.panda, Totem.weasel, Totem.mongoose, Totem.rat, Totem.eagle, Totem.pony, Totem.doowy]
            return totems[Int(arc4random_uniform(UInt32(totems.count)))]
        }
    }
    //===============================
    // MARK: - Public Methods
    //===============================
    public init(category: Category, material: Material) {
        self.category = category
        self.material = material
        self.totem = Totem.random
    }
    //===============================
    // MARK: Private Methods
    //===============================
    private func getCategoryPower()-> Int {
        switch category {
        case .sword:
            return 10
        case .stick:
            return 20
        case .shield:
            return 5
        case .ax:
            return 20
        }
    }
    private func getMaterialPower()-> Int {
        switch material {
        case .wood:
            return 0
        case .iron:
            return 5
        case .diamond:
            return 10
        }
    }
}

