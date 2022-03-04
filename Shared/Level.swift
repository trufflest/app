enum Level {
    static let max = 1
    private static let levels = [Level1()]
    
    static subscript(_ level: UInt8) -> LevelProtocol {
        levels[.init(level) - 1]
    }
}
