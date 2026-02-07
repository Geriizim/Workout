import Foundation

struct ContentVersioningService {
    static let seededVersionKey = "seededContentVersion"

    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    func shouldApply(currentVersion: Int, seededVersion: Int) -> Bool {
        currentVersion > seededVersion
    }

    func applyIfNeeded(currentVersion: Int, seededVersion: Int) {
        guard shouldApply(currentVersion: currentVersion, seededVersion: seededVersion) else { return }
        defaults.set(currentVersion, forKey: Self.seededVersionKey)
    }

    func resetSeededVersion() {
        defaults.set(0, forKey: Self.seededVersionKey)
    }
}
