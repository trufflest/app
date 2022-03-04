import SwiftUI

struct Comic: View {
    let session: Session
    let level: UInt8
    @State private var selection = 0
    
    var body: some View {
        ZStack {
            TabView(selection: $selection) {
                ForEach(Level[level].comics, id: \.self) { index in
                    VStack {
                        Image("Comic_\(index)")
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
                        Spacer()
                    }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            VStack {
                HStack {
                    Spacer()
                    Button("Skip") {
                        
                    }
                }
                HStack {
                    
                }
                Spacer()
            }
        }
    }
}
