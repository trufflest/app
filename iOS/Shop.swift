import SwiftUI
import StoreKit
import Master

struct Shop: View {
    @SwiftUI.State private var state = Store.Status.loading
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    Text("**Level 1** is free to play\n\(Text("Purchase the next levels to continue playing").foregroundColor(.secondary))")
                        
                    Text(.init(Copy.purchases))
                        .foregroundStyle(.secondary)
                }
                .listRowBackground(Color.clear)
                .listSectionSeparator(.hidden)
                .listRowSeparator(.hidden)
                .font(.callout)
                
                Section {
                    NavigationLink("Why do you have to buy each level?", destination: Why.init)
                        .font(.footnote)
                }
                
                Section {
                    purchases
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Purchases")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Restore purchases") {
                        Task {
                            await store.restore()
                        }
                    }
                    .foregroundStyle(.secondary)
                    .font(.callout)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
        .onReceive(store.status) {
            state = $0
        }
        .task {
            await store.load()
        }
    }
    
    @ViewBuilder private var purchases: some View {
        switch state {
        case .loading:
            Image(systemName: "hourglass")
                .font(.largeTitle.weight(.light))
                .symbolRenderingMode(.multicolor)
                .allowsHitTesting(false)
                .frame(maxWidth: .greatestFiniteMagnitude)
                .listRowBackground(Color.clear)
        case let .error(error):
            Text(verbatim: error)
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
                .padding()
                .listRowBackground(Color.clear)
        case let .products(products):
            ForEach(products, content: item(product:))
        }
    }
    
    @ViewBuilder private func item(product: Product) -> some View {
        HStack {
            Text(verbatim: product.displayName)
            + Text("\n")
            + Text(verbatim: product.description)
                .foregroundColor(.secondary)
                .font(.footnote)
            
            Spacer()
            
            if let level = Store.Item(id: product.id)?.level,
               Defaults.has(level: level) {
                Text("Purchased")
                    .foregroundColor(.accentColor)
                    .font(.footnote.weight(.medium))
                Image(systemName: "checkmark.circle.fill")
                    .font(.title.weight(.light))
                    .symbolRenderingMode(.hierarchical)
                    .foregroundColor(.accentColor)
            } else {
                Text(verbatim: product.displayPrice)
                    .font(.footnote.monospacedDigit())
                    .allowsHitTesting(false)
                
                Button {
                    Task {
                        await store.purchase(product)
                    }
                } label: {
                    Text("Purchase")
                        .font(.footnote.weight(.medium))
                        .padding(.horizontal, 5)
                        .padding(.vertical, 2)
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .padding(.vertical, 6)
            }
        }
    }
}
