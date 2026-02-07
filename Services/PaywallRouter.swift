import Foundation

struct PaywallRouter {
    func shouldShowPaywall(totalCompletions: Int, attemptedLocked: Bool) -> Bool {
        if attemptedLocked { return true }
        return totalCompletions >= 2
    }

    func shouldShowUpsellBanner(lastCompletionWasFree: Bool, isDismissed: Bool) -> Bool {
        lastCompletionWasFree && !isDismissed
    }
}
