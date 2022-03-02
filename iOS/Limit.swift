import SwiftUI

struct Limit: View {
    let level: UInt8
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Text("Level " + level.formatted())
                .font(.largeTitle)
            
            Text(.init("**Level " + level.formatted() + "** is still in development\nand will be available soon."))
                .font(.callout)
                .foregroundStyle(.secondary)
                .padding(.bottom)
            
            Button("Accept") {
                dismiss()
            }
            .frame(maxHeight: 40)
            .buttonStyle(.bordered)
            .padding(.top)
        }
    }
}
