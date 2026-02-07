import SwiftUI

struct OnboardingFlowView: View {
    @State private var step = 0
    @State private var accepted = false
    var onFinish: () -> Void

    var body: some View {
        VStack(spacing: DS.Spacing.md) {
            Text("onboarding.step.\(step+1)")
            if step == 0 { TrackCard(title: "track.office.name", subtitle: "onboarding.best.office", theme: .office) }
            if step == 1 { Text("onboarding.preferences") }
            if step == 2 { Text("onboarding.reminder") }
            if step == 3 {
                Toggle("safety.understand", isOn: $accepted)
                Text("safety.disclaimer")
            }
            PrimaryButton(titleKey: "onboarding.next") { if step < 3 { step += 1 } else if accepted { onFinish() } }
            SecondaryButton(titleKey: "onboarding.skip") { onFinish() }
        }.padding()
    }
}
