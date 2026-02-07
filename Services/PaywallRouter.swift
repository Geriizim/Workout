import Foundation

struct PaywallRouter {
    func shouldShowPaywall(totalCompletions: Int, attemptedLocked: Bool) -> Bool {
        attemptedLocked || totalCompletions >= 2
    }

    func shouldShowUpsellBanner(lastCompletionWasFree: Bool, isDismissed: Bool) -> Bool {
        lastCompletionWasFree && !isDismissed
    }
}
