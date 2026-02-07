import SwiftUI

struct BadgePill: View {
    let key: LocalizedStringKey
    var body: some View { Text(key).font(.caption).padding(.horizontal, DS.Spacing.sm).padding(.vertical, DS.Spacing.xs).background(Color.accentColor.opacity(0.14)).clipShape(Capsule()) }
}
