// MARK: - Game
public class Game {
    private var teams: [Team]
    private var rounds: [Round]
    private static let nbMaxTeam: Int = 2
    private var isOver: Bool {
        if findLooser() != nil {
            return true
        } else {
            return false
        }
    }
    public init(teams: [Team]) {
        self.teams = teams
        self.rounds = [Round]()
    }
    private func findWinner() -> Team? {
        for team in teams {
            if let loosingTeam = findLooser() {
                if team.player != loosingTeam.player {
                    return team
                }
            }
        }
        return nil
    }
    private func findLooser() -> Team? {
        for team in teams {
            if team.nbCharacterAlive == 0 {
                return team
            }
        }
        return nil
    }
}
