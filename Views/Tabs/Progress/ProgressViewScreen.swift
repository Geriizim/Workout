import SwiftUI

struct ProgressViewScreen: View {
    var body: some View {
        ScrollView {
            VStack(spacing: DS.Spacing.md) {
                Card { Text("progress.momentum"); ProgressRing(progress: 0.7).frame(width: 90, height: 90) }
                Card { Text("progress.heatmap") }
                Card { Text("progress.weekly") }
                Card { BadgePill(key: "badge.first_session") }
            }.padding()
        }
    }
}
