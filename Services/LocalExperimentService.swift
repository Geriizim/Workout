import Foundation

final class LocalExperimentService {
    func variant(for key: String) -> String {
        let defaults = UserDefaults.standard
        if let existing = defaults.string(forKey: "exp_\(key)") { return existing }
        let v = (defaults.integer(forKey: "seededContentVersion") % 2 == 0) ? "A" : "B"
        defaults.set(v, forKey: "exp_\(key)")
        EventLogger.log("experiment_variant", meta: ["key": key, "variant": v])
        return v
    }
}
