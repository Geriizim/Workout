import XCTest
@testable import MicroStreaksLogic

final class SessionScalingServiceTests: XCTestCase {
    let service = SessionScalingService()

    func testClampBoundaries() {
        let scaled = service.scaledDurations(baseDurations: [10, 200], targetMinutes: 8)
        XCTAssertTrue((20...90).contains(scaled[0]))
        XCTAssertTrue((20...90).contains(scaled[1]))
    }

    func testSixMinuteScalingWithinTolerance() {
        let base = Array(repeating: 60, count: 8)
        let scaled = service.scaledDurations(baseDurations: base, targetMinutes: 6)
        XCTAssertLessThanOrEqual(abs(scaled.reduce(0,+) - 360), 10)
    }

    func testTwelveMinuteScalingWithinTolerance() {
        let base = Array(repeating: 60, count: 8)
        let scaled = service.scaledDurations(baseDurations: base, targetMinutes: 12)
        XCTAssertLessThanOrEqual(abs(scaled.reduce(0,+) - 720), 10)
    }
}
