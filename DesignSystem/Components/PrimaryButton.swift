import SwiftUI

struct PrimaryButton: View {
    let titleKey: LocalizedStringKey
    var action: () -> Void

    var body: some View {
        Button(action: { UIImpactFeedbackGenerator(style: .light).impactOccurred(); action() }) {
            Text(titleKey).font(.headline).frame(maxWidth: .infinity).padding(.vertical, DS.Spacing.sm)
        }
        .background(LinearGradient(colors: [.accentColor, .accentColor.opacity(0.8)], startPoint: .leading, endPoint: .trailing))
        .foregroundStyle(.white)
        .clipShape(RoundedRectangle(cornerRadius: DS.Radius.button))
        .contentShape(Rectangle())
    }
}
