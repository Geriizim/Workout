import SwiftUI

struct Chip: View {
    let title: LocalizedStringKey
    let selected: Bool
    var onTap: () -> Void
    var body: some View {
        Button(action: onTap) {
            Text(title).padding(.horizontal, DS.Spacing.sm).padding(.vertical, DS.Spacing.xs)
                .background(selected ? Color.accentColor : Color.secondary.opacity(0.12))
                .foregroundStyle(selected ? .white : .primary)
                .clipShape(RoundedRectangle(cornerRadius: DS.Radius.chip))
        }
    }
}
