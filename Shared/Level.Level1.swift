extension Level {
    struct Level1: LevelProtocol {
        let title = "The Meadows"
        let items = [Scene.Item.spikes, .lizards]
        let comics = [
            Comic(id: 0, text: """
**Breaking News**
In an impromptu press conference Melon Tusk, the glorified entrepreneur rockstar and multi trillionaire
"""),
            .init(id: 1, text: """
Announced a new line of luxury electric vehicles for his signature company _Lesta, Inc._
"""),
            .init(id: 2, text: """
_The next step for humanity_ he called it.
""")]
    }
}
