import SwiftUI

struct Froob: View {
    let level: UInt8
    @State private var shop = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Text("Level " + level.formatted())
                .font(.largeTitle)
            
            Text(.init("**Level " + level.formatted() + "** is an _In-App Purchase_.\nPurchase it to continue playing."))
                .font(.callout)
                .foregroundStyle(.secondary)
                .padding(.bottom)
            
            Button("In-App Purchases") {
                shop = true
            }
            .frame(maxHeight: 40)
            .buttonStyle(.borderedProminent)
            .padding(.top)
            .sheet(isPresented: $shop) {
                dismiss()
            } content: {
                Shop()
            }

            Button("Cancel") {
                dismiss()
            }
            .frame(maxHeight: 40)
            .buttonStyle(.plain)
            .foregroundStyle(.secondary)
        }
    }
}
