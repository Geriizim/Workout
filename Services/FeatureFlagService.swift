import Foundation

final class FeatureFlagService {
    private(set) var flags: [String: Bool] = [:]
    init(bundle: Bundle = .main) {
        if let url = bundle.url(forResource: "FeatureFlags", withExtension: "json"),
           let data = try? Data(contentsOf: url),
           let map = try? JSONDecoder().decode([String: Bool].self, from: data) { flags = map }
    }
    func enabled(_ key: String) -> Bool { flags[key] ?? false }
}
