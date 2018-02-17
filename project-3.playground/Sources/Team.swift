public class Team {
    // MARK: - Stored Properties
    public let player: String
    public var characters: [AnyObject]
    // MARK: Calculated Properties
    public var nbCharacterAlive: Int {
        return countCharacterAlive()
    }
    // MARK: - Public Methods
    public init(player: String, characters: [AnyObject]) {
        self.player = player
        self.characters = characters
    }
    // MARK: Private Methods
    private func countCharacterAlive() -> Int {
        var nbCharacterAlive: Int = 0
        for character in characters {
            if (character as! GameCharacter).isAlive{
                nbCharacterAlive += 1
            }
        }
        return nbCharacterAlive
    }
}
