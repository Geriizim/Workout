import SwiftUI

struct Card<Content: View>: View {
    let content: Content
    init(@ViewBuilder content: () -> Content) { self.content = content() }
    var body: some View {
        content.padding(DS.Spacing.md)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.background)
            .clipShape(RoundedRectangle(cornerRadius: DS.Radius.card))
            .shadow(color: .black.opacity(0.08), radius: 6, y: 2)
    }
}
