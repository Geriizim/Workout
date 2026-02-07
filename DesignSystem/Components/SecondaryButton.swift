import SwiftUI

struct SecondaryButton: View {
    let titleKey: LocalizedStringKey
    var action: () -> Void
    var body: some View {
        Button(action: action) {
            Text(titleKey).font(.headline).frame(maxWidth: .infinity).padding(.vertical, DS.Spacing.sm)
        }
        .background(Color.secondary.opacity(0.12))
        .clipShape(RoundedRectangle(cornerRadius: DS.Radius.button))
    }
}
