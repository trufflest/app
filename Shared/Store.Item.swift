import Foundation
import UserNotifications
import Master

extension Store {
    struct Item {
        static var all: [Item] {
            (0 ..< 5)
                .map(Self.init(level:))
        }
        
        var id: String {
            "trufflest.level\(level)"
        }
        
        let level: UInt8
        
        init(level: UInt8) {
            self.level = level
        }
        
        init?(id: String) {
            guard let level = UInt8(id.replacingOccurrences(of: "trufflest.level", with: "")) else { return nil }
            self.level = level
        }
        
        func purchased(active: Bool) async {
            if active {
                Defaults.purchase(level: level)
                await UNUserNotificationCenter.send(message: "Purchased Level \(level)!")
            } else {
                Defaults.remove(level: level)
            }
        }
    }
}
