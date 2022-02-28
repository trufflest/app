import SwiftUI
import StoreKit
import Master

struct Store: View {
    @State private var state = Store.Status.loading
    
    var body: some View {
        VStack {
            Image("Darkside")
            
            Text("The Dark Side of the Moon")
                .font(.title2.weight(.medium))
                .foregroundColor(.primary)
                .frame(maxWidth: .greatestFiniteMagnitude)
            
            if Defaults.isPremium {
                isPremium
            } else {
                notPremium
            }
        }
        .animation(.easeInOut(duration: 0.3), value: state)
        .onReceive(store.status) {
            state = $0
        }
        .task {
            await store.load()
        }
    }
    
    @ViewBuilder private var isPremium: some View {
        Spacer()
        
        Image(systemName: "checkmark.circle.fill")
            .font(.largeTitle.weight(.light))
            .symbolRenderingMode(.hierarchical)
            .foregroundColor(.accentColor)
            .imageScale(.large)
            .padding(.bottom)
        
        Text("We received your support")
            .foregroundColor(.secondary)
            .font(.body)
        Text("Thank you!")
            .foregroundColor(.primary)
            .font(.body)
            .padding(.top, 1)
        
        Spacer()
    }
    
    @ViewBuilder private var notPremium: some View {
        switch state {
        case .loading:
            Spacer()
            Image(systemName: "hourglass")
                .font(.largeTitle.weight(.light))
                .symbolRenderingMode(.multicolor)
                .allowsHitTesting(false)
        case let .error(error):
            Spacer()
            Text(verbatim: error)
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: 240)
        case let .products(products):
            item(product: products.first!)
        }
        
        Spacer()
        
        Text("Already supporting Moon Health?")
            .foregroundColor(.secondary)
            .font(.caption)
        
        Button {
            Task {
                await store.restore()
            }
        } label: {
            Label("Restore purchases", systemImage: "leaf.arrow.triangle.circlepath")
                .imageScale(.large)
                .font(.footnote)
        }
        .buttonStyle(.bordered)
        .tint(.secondary)
        .padding(.bottom, 40)
    }
    
    @ViewBuilder private func item(product: Product) -> some View {
        Text(verbatim: product.description)
            .foregroundColor(.secondary)
            .font(.callout)
            .multilineTextAlignment(.center)
            .fixedSize(horizontal: false, vertical: true)
            .frame(maxWidth: 190)
            .allowsHitTesting(false)
        
        Spacer()
        
        Text(verbatim: product.displayPrice)
            .font(.body.monospacedDigit())
            .padding(.top)
            .frame(maxWidth: .greatestFiniteMagnitude)
            .allowsHitTesting(false)
        Button {
            Task {
                await store.purchase(product)
            }
        } label: {
            Text("Purchase")
                .font(.callout)
                .padding(.horizontal, 10)
                .padding(.vertical, 3)
                .allowsHitTesting(false)
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
    }
}
