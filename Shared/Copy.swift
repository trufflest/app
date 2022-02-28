import Foundation

enum Copy {
    static let noPurchases = """
No In-App Purchases available at the moment, try again later.
"""
    
    static let purchases = """
You only purchase a _Level_ once and you can play it as many times as you want.
But you can only play **Level 2** after finishing **Level 1**, and **Level 3** after **Level 2**, and so on.
You can always **Restart** the game and play them all again.
"""
    
    static let why = """
**Truffle Forest** is a small game developed by an indie team.

We want everyone to play it, and we would love to be able to offer it for free. But we don't have, and don't want investors, we also don't monetize the game with ads, or selling your data, or adding some creepy weirdo algorithms to keep track of your behaviour.

But we still need to monetize somehow, otherwise it would not be sustainable and we could not give it maintenance and updates.

You can play the first Level of the game, Level 1, for free, as many times as you want. Every subsequent Level you will have to buy separately. It is done this way so that you can get an first taste of the game and confirm if you like it or not before making any payment for it.

Each Level is sold separately, but a really small price, our idea is to keep improving and maintaining the game, not the become rich with it. The moment you don't like the game anymore you can avoid purchasing any more levels. Each Level is an In-App Purchase, it is Non-Consumable, meaning you only buy it once and you can use it forever, on all your devices.

We advise you not to purchase any Level until you can actually play it. For example, if you purchase **Level 3** you can only play it after you have finished Levels 1 & 2.
"""
}
