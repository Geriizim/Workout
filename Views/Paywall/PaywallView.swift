import SwiftUI

struct PaywallView: View {
    @StateObject private var purchaseService = PurchaseService()
    var body: some View {
        ScrollView {
            VStack(spacing: DS.Spacing.md) {
                Text("paywall.title").font(.title.bold())
                Card { Text("paywall.benefits") }
                PrimaryButton(titleKey: "paywall.try_pro") {}
                SecondaryButton(titleKey: "paywall.restore") { Task { _ = await purchaseService.restore() } }
                Text("paywall.disclosure").font(.caption)
            }.padding()
        }.task { await purchaseService.load(); EventLogger.log("paywall_view") }
    }
}
