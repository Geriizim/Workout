import SwiftUI

struct TrackCard: View {
    let title: LocalizedStringKey
    let subtitle: LocalizedStringKey
    let theme: TrackTheme
    var body: some View {
        Card {
            HStack {
                Image(systemName: theme.iconName).font(.title2).foregroundStyle(theme.accent)
                VStack(alignment: .leading, spacing: DS.Spacing.xs) {
                    Text(title).font(.headline)
                    Text(subtitle).font(.caption).foregroundStyle(.secondary)
                }
            }
        }
        .background(theme.gradient)
        .clipShape(RoundedRectangle(cornerRadius: DS.Radius.card))
    }
}
