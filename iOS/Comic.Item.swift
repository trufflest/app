import SwiftUI

extension Comic {
    struct Item: View {
        let comic: Level.Comic
        
        var body: some View {
            VStack {
                Image("Comic_\(comic.id)")
                Text(comic.text)
                Spacer()
            }
        }
    }
}
