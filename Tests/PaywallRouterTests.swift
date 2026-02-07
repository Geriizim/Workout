import XCTest
@testable import MicroStreaksLogic

final class PaywallRouterTests: XCTestCase {
    let router = PaywallRouter()

    func testDoesNotShowBeforeTwoCompletions() {
        XCTAssertFalse(router.shouldShowPaywall(totalCompletions: 0, attemptedLocked: false))
        XCTAssertFalse(router.shouldShowPaywall(totalCompletions: 1, attemptedLocked: false))
    }

    func testShowsAfterTwoCompletions() {
        XCTAssertTrue(router.shouldShowPaywall(totalCompletions: 2, attemptedLocked: false))
    }

    func testShowsWhenLockedTapped() {
        XCTAssertTrue(router.shouldShowPaywall(totalCompletions: 0, attemptedLocked: true))
    }

    func testUpsellBannerDismissal() {
        XCTAssertTrue(router.shouldShowUpsellBanner(lastCompletionWasFree: true, isDismissed: false))
        XCTAssertFalse(router.shouldShowUpsellBanner(lastCompletionWasFree: true, isDismissed: true))
    }
}
