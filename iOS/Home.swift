import SwiftUI
import Master

struct Home: View {
    let session: Session
    @SwiftUI.State private var model = Archive()
    @SwiftUI.State private var settings = false
    @SwiftUI.State private var purchases = false
    @SwiftUI.State private var restart = false
    @SwiftUI.State private var froob = false
    
    var body: some View {
        HStack {
            VStack {
                Image("Logo")
                Text("Truffle Forest")
                    .font(.headline)
                Text(model.truffles.formatted() + " truffles")
                    .font(.callout.monospacedDigit())
                    .foregroundColor(.secondary)
            }
            .frame(width: 400)
            List {
                Section("Level " + model.level.formatted()) {
                    Button {
                        if Defaults.has(level: model.level) {
                            session.play(level: model.level)
                        } else {
                            froob = true
                        }
                    } label: {
                        Label("Play", systemImage: "paperplane.fill")
                    }
                    .sheet(isPresented: $froob) {
                        Froob(level: model.level)
                    }
                    
                    Button {
                        restart = true
                    } label: {
                        Label("Restart", systemImage: "flame.fill")
                    }
                    .disabled(model.level == 1)
                    .foregroundColor(model.level > 1 ? .pink : nil)
                    .confirmationDialog("Restart game to the beginning?", isPresented: $restart) {
                        Button("Cancel", role: .cancel) {
                            
                        }
                        Button("Restart", role: .destructive) {
                            Task {
                                await cloud.restart()
                            }
                        }
                    }
                }
                .headerProminence(.increased)
                
                Section {
                    Button {
                        settings = true
                    } label: {
                        Label("Settings", systemImage: "slider.horizontal.3")
                    }
                    .sheet(isPresented: $settings) {
                        Settings(sounds: model.settings.sounds)
                    }
                }
                
                Section {
                    Button {
                        purchases = true
                    } label: {
                        Label("Purchases", systemImage: "cart.fill")
                    }
                    .sheet(isPresented: $purchases, content: Shop.init)
                }
            }
            .listStyle(.insetGrouped)
        }
        .onReceive(cloud) {
            model = $0
        }
    }
}
