import Foundation

struct RecommendationService {
    func recommend(sessions: [Session], track: String, recentSessionKeys: Set<String>, feedback: String?) -> [Session] {
        let filtered = sessions.filter { $0.trackStableKey == track && !recentSessionKeys.contains($0.stableKey) }
        return filtered.sorted { lhs, rhs in
            score(lhs, feedback: feedback) > score(rhs, feedback: feedback)
        }
    }

    private func score(_ session: Session, feedback: String?) -> Int {
        var s = 100
        if feedback == "too_hard" { if session.baseDurationMinutes <= 8 { s += 20 }; if session.level == "beginner" { s += 30 } }
        if feedback == "too_easy" { if session.baseDurationMinutes >= 8 { s += 20 }; if session.level != "beginner" { s += 30 } }
        if session.isPro { s -= 5 }
        return s
    }
}
