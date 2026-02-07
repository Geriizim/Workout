import SwiftUI

struct TodayView: View {
    @State private var momentum: Double = 0.4
    var body: some View {
        ScrollView {
            VStack(spacing: DS.Spacing.md) {
                Card {
                    Text("today.session.title").font(.title3.bold())
                    Text("today.session.subtitle")
                    PrimaryButton(titleKey: "today.start") {}
                }
                Card {
                    Text("today.momentum")
                    ProgressRing(progress: momentum).frame(width: 80, height: 80)
                }
                Card { Text("today.streak") }
                HStack { SecondaryButton(titleKey: "today.reset") {}; SecondaryButton(titleKey: "today.pick") {} }
            }.padding()
        }
    }
}
