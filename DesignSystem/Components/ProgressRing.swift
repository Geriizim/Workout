import SwiftUI

struct ProgressRing: View {
    var progress: Double
    var body: some View {
        ZStack {
            Circle().stroke(.secondary.opacity(0.2), lineWidth: 8)
            Circle().trim(from: 0, to: progress).stroke(.accent, style: StrokeStyle(lineWidth: 8, lineCap: .round)).rotationEffect(.degrees(-90)).animation(.easeOut, value: progress)
        }
    }
}
