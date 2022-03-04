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
"""),
            .init(id: 3, text: """
At _Lesta, Inc._ we have been building luxury vehicles for long time and dudes love them, they sell like fresh bread
"""),
            .init(id: 4, text: """
Nothing shouts out more personality than you driving downtown in a Lesta, The American Dream.
"""),
            .init(id: 5, text: """
But I get calls in the middle of night, they tell me "Bro, love my Lesta and all"
"""),
            .init(id: 6, text: """
"Problem is I can't really go to the Burning M. with it can I? what would they think of me?"
"""),
            .init(id: 7, text: """
And then I realised it: Bros need something bigger, something that sweats out manliness.
"""),
            .init(id: 8, text: """
That is why we are introducing _The Bro Truck_
"""),
            .init(id: 9, text: """
Stay tuned we will give you a sneak peek soonish.
""")]
    }
}
