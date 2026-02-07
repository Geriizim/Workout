import SwiftUI

struct EmptyStateView: View {
    let title: LocalizedStringKey
    let subtitle: LocalizedStringKey
    var body: some View {
        VStack(spacing: DS.Spacing.sm) {
            Image(systemName: "sparkles").font(.largeTitle)
            Text(title).font(.headline)
            Text(subtitle).font(.body).foregroundStyle(.secondary).multilineTextAlignment(.center)
        }.padding()
    }
}
