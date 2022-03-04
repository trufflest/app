extension Level {
    struct Level1: LevelProtocol {
        let title = "The Meadows"
        let items = [Scene.Item.spikes, .lizards]
        let comics = [
            Comic(id: 0, text: "Hello world"),
            .init(id: 1, text: "Lorem ipsum")]
    }
}
