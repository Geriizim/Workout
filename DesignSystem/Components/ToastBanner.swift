import SwiftUI

struct ToastBanner: View {
    let key: LocalizedStringKey
    var isError = false
    var body: some View {
        Text(key).font(.subheadline).padding().frame(maxWidth: .infinity)
            .background(isError ? Color.red.opacity(0.2) : Color.green.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: DS.Radius.card))
    }
}
