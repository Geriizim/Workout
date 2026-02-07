import SwiftUI

struct WorkoutPlayerView: View {
    var body: some View {
        VStack(spacing: DS.Spacing.md) {
            ProgressView(value: 0.4)
            Text("player.time_remaining")
            Card { Text("player.exercise") }
            HStack { SecondaryButton(titleKey: "player.pause") {}; SecondaryButton(titleKey: "player.skip") {}; SecondaryButton(titleKey: "player.end") {} }
            Text("player.next")
        }.padding()
    }
}
