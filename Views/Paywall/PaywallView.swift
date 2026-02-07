import SwiftUI
import StoreKit

struct PaywallView: View {
    @StateObject private var purchaseService = PurchaseService()
    @State private var isPurchasing = false
    @State private var showError = false

    var body: some View {
        ScrollView {
            VStack(spacing: DS.Spacing.md) {
                Text("paywall.title").font(.title.bold())
                Card { Text("paywall.benefits") }
                PrimaryButton(titleKey: "paywall.try_pro") {
                    Task { await startPurchase() }
                }
                .disabled(isPurchasing || purchaseService.products.isEmpty)

                SecondaryButton(titleKey: "paywall.restore") {
                    Task { _ = await purchaseService.restore() }
                }
                Text("paywall.disclosure").font(.caption)
            }
            .padding()
        }
        .task {
            await purchaseService.load()
            EventLogger.log("paywall_view")
        }
        .onChange(of: purchaseService.errorKey) { _, newValue in
            showError = newValue != nil
        }
        .alert("", isPresented: $showError) {
            Button("settings.ok") {}
        } message: {
            Text(LocalizedStringKey(purchaseService.errorKey ?? "paywall.error.purchase"))
        }
    }

    private func startPurchase() async {
        guard !isPurchasing, let product = preferredProduct else { return }
        isPurchasing = true
        _ = await purchaseService.buy(product)
        isPurchasing = false
    }

    private var preferredProduct: Product? {
        purchaseService.products.sorted(by: { $0.price < $1.price }).first
    }
}
