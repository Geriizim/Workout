import Foundation

struct ContentVersioningService {
    func shouldApply(currentVersion: Int, seededVersion: Int) -> Bool {
        currentVersion > seededVersion
    }

    func applyIfNeeded(currentVersion: Int, seededVersion: Int) {
        guard shouldApply(currentVersion: currentVersion, seededVersion: seededVersion) else { return }
        UserDefaults.standard.set(currentVersion, forKey: "seededContentVersion")
    }
}
