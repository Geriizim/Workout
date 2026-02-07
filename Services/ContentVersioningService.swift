import Foundation

struct ContentVersioningService {
    func applyIfNeeded(currentVersion: Int, seededVersion: Int) {
        guard currentVersion > seededVersion else { return }
        UserDefaults.standard.set(currentVersion, forKey: "seededContentVersion")
    }
}
