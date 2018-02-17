public class Display {
    // MARK: - Stored Properties
    private let interfaceLineLength: Int = 60
    // MARK: - Methods
    public init(welcomeWord: String) {
        sayWelcome(welcomeWord: welcomeWord)
    }
    private func sayWelcome(welcomeWord: String) {
        drawFrameOneText(text: welcomeWord)
    }
    public func clearScreen() {
        for _ in 1...20 {
            print("\n")
        }
    }
    public func drawSimpleLine() {
        var line: String = "+"
        for _ in 1...self.interfaceLineLength {
            line += "-"
        }
        line += "+"
        print(line)
    }
    public func drawDoubleLine() {
        var line: String = "+"
        for _ in 1...self.interfaceLineLength {
            line += "="
        }
        line += "+"
        print(line)
    }
    public func drawEmptyLine() {
        var line: String = "|"
        for _ in 1...self.interfaceLineLength {
            line += " "
        }
        line += "|"
        print(line)
    }
    private func drawTextLine(text: String) {
        let nbChar: Int = text.count
        let prefix: Int = (self.interfaceLineLength - nbChar) / 2
        let suffix: Int = (self.interfaceLineLength - nbChar - prefix)
        var lineText: String = "|"
        for _ in 1...prefix {
            lineText += " "
        }
        lineText += text
        for _ in 1...suffix {
            lineText += " "
        }
        lineText += "|"
        print(lineText)
    }
    public func drawFrameOneText(text: String) {
        drawSimpleLine()
        drawEmptyLine()
        drawTextLine(text: text)
        drawEmptyLine()
        drawSimpleLine()
    }
}
