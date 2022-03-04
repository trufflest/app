import SwiftUI

extension Comic {
    struct Item: View {
        let comic: Level.Comic
        
        var body: some View {
            VStack(spacing: 0) {
                Image("Comic_\(comic.id)")
                    .frame(height: 240)
                    .padding(.vertical, 20)
                Text(.init(comic.text))
                    .font(.callout)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: 480)
                Spacer()
            }
        }
    }
}
