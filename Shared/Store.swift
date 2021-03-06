import StoreKit
import UserNotifications
import Combine

struct Store {
    let status = CurrentValueSubject<Status, Never>(.loading)
    private var restored = false
    
    init() {
        Task
            .detached {
                for await result in Transaction.updates {
                    if case let .verified(safe) = result {
                        await safe.process()
                    }
                }
            }
    }
    
    @MainActor func load() async {
        do {
            let products = try await Product.products(for: Item.all.map(\.id))
            if products.isEmpty {
                status.send(.error(Copy.noPurchases))
            } else {
                status.send(
                    .products(
                        products
                            .sorted {
                                $0.displayName.caseInsensitiveCompare($1.displayName) == .orderedAscending
                            }))
            }
        } catch let error {
            status.send(.error("Unable to connect to the App Store.\n" + error.localizedDescription))
        }
    }
    
    @MainActor func purchase(_ product: Product) async {
        status.send(.loading)

        do {
            switch try await product.purchase() {
            case let .success(verification):
                if case let .verified(safe) = verification {
                    await safe.process()
                    await load()
                } else {
                    status.send(.error("Purchase verification failed."))
                }
            case .pending:
                await load()
                await UNUserNotificationCenter.send(message: "Purchase is pending...")
            default:
                await load()
            }
        } catch let error {
            status.send(.error(error.localizedDescription))
        }
    }
    
    @MainActor mutating func restore() async {
        status.send(.loading)
        
        if restored {
            try? await AppStore.sync()
        }
        
        for await result in Transaction.currentEntitlements {
            if case let .verified(safe) = result {
                await safe.process()
            }
        }
        
        await load()
        restored = true
    }
    
    func purchase(legacy: SKProduct) async {
        guard let product = try? await Product.products(for: [legacy.productIdentifier]).first else { return }
        await purchase(product)
    }
}
