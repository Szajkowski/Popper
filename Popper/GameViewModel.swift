import SwiftUI

class GameViewModel: ObservableObject {
    @Published var bubbles: [Bubble] = []
    @Published var score: Int = 0
    @Published var misses: Int = 0
    @Published var gameOver: Bool = false
    
    var bubbleSpeed: CGFloat {
        switch score {
        case 0..<10:
            return 200  
        case 10..<30:
            return 400
        default:
            return 600
        }
    }
    
    var spawnInterval: TimeInterval {
        switch score {
        case 0..<10:
            return 1.0
        case 10..<30:
            return 0.6
        default:
            return 0.4
        }
    }
    
    let maxMisses = 3
    
    private var timer: Timer?
    
    func startGame() {
        bubbles.removeAll()
        score = 0
        misses = 0
        gameOver = false
        
        restartSpawnTimer()
    }
    
    func stopGame() {
        timer?.invalidate()
        bubbles.removeAll()
    }
    
    func spawnBubble() {
        bubbles.append(
            Bubble(
                x: CGFloat.random(in: 40...(UIScreen.main.bounds.width - 40)),
                startTime: Date(),
                speed: bubbleSpeed
            )
        )
    }
    
    func removeBubble(_ bubble: Bubble, popped: Bool) {
        guard let index = bubbles.firstIndex(where: { $0.id == bubble.id }) else {
            return
        }
        if bubbles[index].popped || bubbles[index].missed {
            return
        }
        
        if popped {
            bubbles[index].popped = true
            score += 1
            
            if score == 10 || score == 30 {
                restartSpawnTimer()
            }
        } else {
            bubbles[index].missed = true
            misses += 1
            if misses >= maxMisses {
                gameOver = true
                stopGame()
            }
        }
        
        bubbles.remove(at: index)
    }
    
    func update(now: Date, topLimit: CGFloat) {
        guard !gameOver else { return }
        
        for i in bubbles.indices {
            let y = yPosition(for: bubbles[i], now: now)
            
            if y <= topLimit - 40 && !bubbles[i].missed {
                bubbles[i].missed = true
                misses += 1
            }
        }
    
        
        if misses >= maxMisses {
            gameOver = true
            stopGame()
        }
    }

    
    func yPosition(for bubble: Bubble, now: Date) -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        let elapsed = now.timeIntervalSince(bubble.startTime)
        return screenHeight - CGFloat(elapsed) * bubble.speed
    }
    
    func restartSpawnTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: spawnInterval, repeats: true) { [weak self] _ in
            self?.spawnBubble()
        }
    }
}
