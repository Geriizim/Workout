import Foundation

struct SeedMergeService {
    func missingKeys(existing: Set<String>, incoming: [String]) -> [String] {
        incoming.filter { !existing.contains($0) }
    }
}
