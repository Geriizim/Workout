import XCTest
@testable import MicroStreaksLogic

final class ContentVersioningTests: XCTestCase {
    let service = ContentVersioningService()

    func testVersionAppliesOnlyWhenHigher() {
        XCTAssertTrue(service.shouldApply(currentVersion: 3, seededVersion: 2))
        XCTAssertFalse(service.shouldApply(currentVersion: 2, seededVersion: 2))
        XCTAssertFalse(service.shouldApply(currentVersion: 1, seededVersion: 2))
    }

    func testMergedStableKeysAvoidsDuplicationOnReseed() {
        let existing: Set<String> = ["office_chin_tuck", "office_neck_rotation"]
        let incoming = ["office_chin_tuck", "office_neck_rotation", "office_wrist_extensor"]
        let merged = SeedMergeService().missingKeys(existing: existing, incoming: incoming)
        XCTAssertEqual(merged, ["office_wrist_extensor"])
    }
}
