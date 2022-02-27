import SwiftUI

struct Settings: View {
    @State var sounds: Bool
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    Toggle("Play sounds", isOn: $sounds)
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
        .onChange(of: sounds) { sounds in
            Task {
                await cloud.toggle(sounds: sounds)
            }
        }
    }
}
