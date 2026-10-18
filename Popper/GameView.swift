import SwiftUI

struct GameView: View {
    @StateObject var viewModel = GameViewModel()
    let topBarHeight: CGFloat = 80
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Pasek z wynikiem
                HStack {
                    Text("Score: \(viewModel.score)")
                        .font(.title)
                        .padding(.leading)
                    Spacer()
                    Text("Misses: \(viewModel.misses)/3")
                        .font(.title)
                        .padding(.trailing)
                }
                .frame(height: topBarHeight)
                .background(Color.gray.opacity(0.2))
                
                // Obszar gry
                TimelineView(.animation) { timeline in
                    ZStack {
                        ForEach(viewModel.bubbles) { bubble in
                            BubbleView(
                                bubble: bubble,
                                y: viewModel.yPosition(for: bubble, now: timeline.date),
                                onPop: {
                                    viewModel.removeBubble(bubble, popped: true)
                                },
                                onMiss: {
                                    viewModel.removeBubble(bubble, popped: false)
                                }
                            )
                        }
                    }
                    .onChange(of: timeline.date) { now in
                        viewModel.update(now: now, topLimit: topBarHeight)
                    }
                }

            }
            
            if viewModel.gameOver {
                VStack {
                    Spacer()
                    Text("Game Over")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                        .background(Color.red.opacity(0.8))
                        .cornerRadius(10)
                    Button("Play Again") {
                        viewModel.startGame()
                    }
                    .padding()
                    Spacer()
                }
            }
        }
        .onAppear {
            viewModel.startGame()
        }
        .onDisappear {
            viewModel.stopGame()
        }
    }
}
