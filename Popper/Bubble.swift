import SwiftUI

struct Bubble: Identifiable {
    let id = UUID()
    let x: CGFloat
    let startTime: Date
    let speed: CGFloat
    var popped = false
    var missed = false
}

