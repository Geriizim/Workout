import Foundation

struct ContentVersioningService {
    static let seededVersionKey = "seededContentVersion"

    func shouldApply(currentVersion: Int, seededVersion: Int) -> Bool {
        currentVersion > seededVersion
    }

    func applyIfNeeded(currentVersion: Int, seededVersion: Int) {
        guard shouldApply(currentVersion: currentVersion, seededVersion: seededVersion) else { return }
        UserDefaults.standard.set(currentVersion, forKey: Self.seededVersionKey)
    }

    func resetSeededVersion() {
        UserDefaults.standard.set(0, forKey: Self.seededVersionKey)
    }
}
