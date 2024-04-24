import SwiftUI
import SpriteKit

struct ContentView: View {
    var body: some View {
        GeometryReader {
            geometry in 
            SpriteView(scene: GameScene(size: geometry.size))
        }
    }
}
