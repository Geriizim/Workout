import Foundation
import StoreKit

/*
 Configure product IDs in App Store Connect and replace IDs below.
 Required disclosures on paywall: auto-renew, billing cadence, cancellation anytime in Settings, and trial terms if offered.
 */
@MainActor
final class PurchaseService: ObservableObject {
    @Published var products: [Product] = []
    @Published var errorKey: String?
    let ids = ["com.microstreaks.pro.monthly", "com.microstreaks.pro.yearly"]

    func load() async {
        do { products = try await Product.products(for: ids) }
        catch { errorKey = "paywall.error.load" }
    }

    func buy(_ product: Product) async -> Bool {
        do {
            let result = try await product.purchase()
            switch result {
            case .success(let verification):
                switch verification {
                case .verified(let transaction):
                    await transaction.finish()
                    EventLogger.log("subscribe_success")
                    return true
                case .unverified:
                    errorKey = "paywall.error.purchase"
                    return false
                }
            case .userCancelled, .pending:
                return false
            @unknown default:
                errorKey = "paywall.error.purchase"
                return false
            }
        } catch {
            errorKey = "paywall.error.purchase"
            return false
        }
    }

    func restore() async -> Bool {
        do { try await AppStore.sync(); EventLogger.log("restore_success"); return true }
        catch { EventLogger.log("restore_fail"); errorKey = "paywall.error.restore"; return false }
    }
}
