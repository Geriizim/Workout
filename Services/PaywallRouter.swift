import Foundation

struct PaywallRouter {
    func shouldShowPaywall(totalCompletions: Int, attemptedLocked: Bool) -> Bool {
        attemptedLocked || totalCompletions >= 2
    }
}
