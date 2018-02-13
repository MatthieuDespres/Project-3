public class Game {
    //===============================
    // MARK: - Stored Properties
    //===============================
    private var teams: [Team]
    private var rounds: [Round]
    private static let nbMaxTeam: Int = 2
    //===============================
    // MARK: Calculated Properties
    //===============================
    private var isWinner: Bool {
        return findWinner()
    }
    //===============================
    // MARK: - Enumeration
    //===============================
    //===============================
    // MARK: - Public Methods
    //===============================
    public init(teams: [Team]) {
        self.teams = teams
        self.rounds = [Round]()
    }
    //===============================
    // MARK: Private Methods
    //===============================
    private func findWinner()-> Bool {
        for team in teams {
            if team.nbCharacterAlive == 0 {
                return true
            } else {
                return false
            }
        }
        return false
    }
}
