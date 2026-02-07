import XCTest
@testable import MicroStreaksLogic

final class StreakServiceTests: XCTestCase {
    let service = StreakService()
    let cal = Calendar(identifier: .gregorian)

    func d(_ y: Int,_ m: Int,_ d: Int) -> Date { cal.date(from: DateComponents(year: y, month: m, day: d))! }

    func testStreakIncrementsConsecutiveDay() {
        let state = StreakSnapshot(currentStreak: 2, lastCompletedDate: d(2026,1,10), freezesUsedThisWeek: 0, lastFreezeResetDate: d(2026,1,10))
        let result = service.applyCompletion(on: d(2026,1,11), state: state, calendar: cal, isPro: false)
        XCTAssertEqual(result.streak, 3)
    }

    func testUsesFreezeForOneMissedDayFreeUser() {
        let state = StreakSnapshot(currentStreak: 4, lastCompletedDate: d(2026,1,10), freezesUsedThisWeek: 0, lastFreezeResetDate: d(2026,1,10))
        let result = service.applyCompletion(on: d(2026,1,12), state: state, calendar: cal, isPro: false)
        XCTAssertEqual(result.streak, 5)
        XCTAssertEqual(result.freezesUsed, 1)
    }

    func testBreakWhenMissBeyondFreeze() {
        let state = StreakSnapshot(currentStreak: 4, lastCompletedDate: d(2026,1,10), freezesUsedThisWeek: 1, lastFreezeResetDate: d(2026,1,10))
        let result = service.applyCompletion(on: d(2026,1,13), state: state, calendar: cal, isPro: false)
        XCTAssertEqual(result.streak, 1)
    }

    func testWeeklyFreezeReset() {
        let freezes = service.weeklyResetIfNeeded(date: d(2026,1,20), freezes: 1, lastReset: d(2026,1,10), calendar: cal)
        XCTAssertEqual(freezes, 0)
    }

    func testMomentum14Window() {
        let ref = d(2026,1,20)
        let dates = [d(2026,1,7), d(2026,1,8), d(2026,1,20), d(2026,1,1)]
        XCTAssertEqual(service.momentum14Count(completions: dates, reference: ref, calendar: cal), 3)
    }
}
