import SwiftUI

struct Comic: View {
    let session: Session
    let level: UInt8
    @State private var selection = 0
    
    var body: some View {
        ZStack {
            TabView(selection: $selection) {
                VStack {
                    Text("Level " + level.formatted())
                        .font(.body)
                        .foregroundStyle(.secondary)
                    Text(Level[level].title)
                        .font(.title)
                }
                .tag(0)
                ForEach(Array(Level[level].comics.enumerated()), id: \.self.0) {
                    Item(comic: $0.1)
                        .tag($0.0 + 1)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            if selection < Level[level].comics.count {
                VStack {
                    HStack {
                        Spacer()
                        Button {
                            session.play(level: level)
                        } label: {
                            Text("Skip")
                                .font(.footnote)
                                .frame(minWidth: 80, minHeight: 50)
                        }
                        .foregroundStyle(.secondary)
                    }
                    Spacer()
                }
            }
            HStack {
                if selection > 0 {
                    Button {
                        if selection > 0 {
                            withAnimation(.easeInOut(duration: 0.4)) {
                                selection -= 1
                            }
                        }
                    } label: {
                        Image(systemName: "chevron.backward.circle.fill")
                            .font(.title)
                            .symbolRenderingMode(.hierarchical)
                            .frame(width: 60, height: 60)
                    }
                } else {
                    Button {
                        session.exit()
                    } label: {
                        Text("Cancel")
                            .font(.callout)
                            .frame(minHeight: 50)
                    }
                    .foregroundStyle(.secondary)
                }
                
                Spacer()
                
                if selection < Level[level].comics.count {
                    Button {
                        if selection < Level[level].comics.count {
                            withAnimation(.easeInOut(duration: 0.4)) {
                                selection += 1
                            }
                        }
                    } label: {
                        Image(systemName: "chevron.forward.circle.fill")
                            .font(.title)
                            .symbolRenderingMode(.hierarchical)
                            .frame(width: 60, height: 60)
                    }
                } else {
                    Button {
                        session.play(level: level)
                    } label: {
                        Text("Play")
                            .font(.callout)
                            .frame(minWidth: 80)
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .padding(.horizontal)
        }
    }
}
