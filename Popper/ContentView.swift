import SwiftUI

enum AppScreen {
    case menu
    case howToPlay
    case game
}

struct ContentView: View {
    @State private var screen: AppScreen = .menu

    var body: some View {
        ZStack {
            if screen == .menu {
                MenuView(screen: $screen)
            }

            if screen == .howToPlay {
                HowToPlayView(screen: $screen)
            }

            if screen == .game {
                GameView()
            }
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

