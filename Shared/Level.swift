enum Level {
    static let max = 1
    
    static func comics(for level: UInt8) -> [Int] {
        switch level {
        case 1:
            return (0 ..< 2).map { $0 }
        default:
            return []
        }
    }
}
