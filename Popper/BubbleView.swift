import SwiftUI

struct BubbleView: View {
    let bubble: Bubble
    let y: CGFloat
    let onPop: () -> Void
    let onMiss: () -> Void
    
    @State private var scale: CGFloat = 1
    @State private var opacity: Double = 1
    @State private var popped = false
    
    var body: some View {
        Circle()
            .fill(
                RadialGradient(
                    gradient: Gradient(colors: [.white, .blue.opacity(0.5)]),
                    center: .center,
                    startRadius: 0,
                    endRadius: 30
                )
            )
            .frame(width: 60, height: 60)
            .scaleEffect(scale)
            .opacity(opacity)
            .position(x: bubble.x, y: y)
            .onTapGesture {
                guard !popped && !bubble.missed else { return }
                
                popped = true
                
                withAnimation(.easeOut(duration: 0.2)) {
                    scale = 0
                    opacity = 0
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    onPop()
                }
            }
            .onChange(of: bubble.missed) { missed in
                if missed {
                    withAnimation(.easeOut(duration: 0.2)) {
                        scale = 0
                        opacity = 0
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        onMiss()
                    }
                }
            }
    }
}
