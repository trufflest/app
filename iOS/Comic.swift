import SwiftUI

struct Comic: View {
    let session: Session
    let level: UInt8
    @State private var selection = 0
    
    var body: some View {
        ZStack {
            TabView(selection: $selection) {
                ForEach(Level[level].comics, content: Item.init(comic:))
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
