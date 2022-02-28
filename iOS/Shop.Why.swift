import SwiftUI

extension Shop {
    struct Why: View {
        var body: some View {
            List {
                Section {
                    Text(.init(Copy.why))
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.vertical)
                        .padding(.vertical, 10)
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Why purchases?")
        }
    }
}
