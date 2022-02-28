import StoreKit

extension Transaction {
    func process() async {
        guard let item = Store.Item(id: productID) else { return }
        await item.purchased(active: revocationDate == nil)
        await finish()
    }
}
