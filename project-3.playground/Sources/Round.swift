public class Round {
    //===============================
    // MARK: - Stored Properties
    //===============================
    private let activeTeam: Team
    private let targetTeam: Team
    private var activeCharacter: GameCharacter
    private var targetCharacter: GameCharacter
    private let actionType: ActionType
    private let healthPoint: Int
    //===============================
    // MARK: Calculated Properties
    //===============================
    private let isPossibleHeal: Bool
    private let isPossibleAttack: Bool
    //===============================
    // MARK: - Enumeration
    //===============================
    public enum ActionType: String {
        case attack = "attaque"
        case heal = "soigne"
    }
    //===============================
    // MARK: - Public Methods
    //===============================
    public init(activeTeam: Team, targetTeam: Team, activeCharacter: GameCharacter, targetCharacter: GameCharacter, actionType: ActionType) {
        self.activeTeam = activeTeam
        self.targetTeam
    }
    //===============================
    // MARK: Private Methods
    //===============================
}
