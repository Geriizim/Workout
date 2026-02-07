import Foundation
import SwiftData

struct ContentSeedService {
    static let contentVersion = 1

    func seedIfNeeded(context: ModelContext) throws {
        let fetch = FetchDescriptor<Track>()
        if (try? context.fetch(fetch).isEmpty) == false { return }
        let tracks: [(String,String,String,String)] = [
            ("office","track.office.name","track.office.desc","office"),
            ("running","track.running.name","track.running.desc","running"),
            ("parents","track.parents.name","track.parents.desc","parents"),
            ("stress","track.stress.name","track.stress.desc","stress"),
            ("mobility","track.mobility.name","track.mobility.desc","mobility"),
            ("strength","track.strength.name","track.strength.desc","strength")
        ]
        for (idx,t) in tracks.enumerated() {
            context.insert(Track(stableKey: t.0, nameKey: t.1, descriptionKey: t.2, iconName: TrackTheme(rawValue: t.3)?.iconName ?? "figure.walk", themeKey: t.3, sortOrder: idx))
            for i in 1...5 {
                let key = "\(t.0)_session_\(i)"
                context.insert(Session(stableKey: key, trackStableKey: t.0, titleKey: "session.\(key).title", level: i < 3 ? "beginner" : "intermediate", isPro: i > 2, tags: ["8min", i < 3 ? "beginner" : "intermediate", i > 2 ? "pro" : "free"]))
            }
        }
        context.insert(Session(stableKey: "two_min_reset", trackStableKey: "stress", titleKey: "session.two_min_reset.title", level: "beginner", baseDurationMinutes: 2, isPro: false, tags: ["2min", "free"]))
        try context.save()
    }
}
