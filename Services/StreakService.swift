import Foundation

struct StreakSnapshot {
    var currentStreak: Int
    var lastCompletedDate: Date?
    var freezesUsedThisWeek: Int
    var lastFreezeResetDate: Date
}

struct StreakResult { var streak: Int; var freezesUsed: Int }

struct StreakService {
    func maxFreezes(isPro: Bool) -> Int { isPro ? 3 : 1 }

    func applyCompletion(on date: Date, state: StreakSnapshot, calendar: Calendar = .current, isPro: Bool) -> StreakResult {
        var streak = state.currentStreak
        var freezes = weeklyResetIfNeeded(date: date, freezes: state.freezesUsedThisWeek, lastReset: state.lastFreezeResetDate, calendar: calendar)
        if let last = state.lastCompletedDate {
            let gap = calendar.dateComponents([.day], from: calendar.startOfDay(for: last), to: calendar.startOfDay(for: date)).day ?? 0
            if gap == 1 { streak += 1 }
            else if gap > 1 {
                let missDays = gap - 1
                let available = max(0, maxFreezes(isPro: isPro) - freezes)
                if missDays <= available && streak > 0 { freezes += missDays; streak += 1 } else { streak = 1 }
            }
        } else { streak = 1 }
        return .init(streak: streak, freezesUsed: freezes)
    }

    func weeklyResetIfNeeded(date: Date, freezes: Int, lastReset: Date, calendar: Calendar = .current) -> Int {
        let c1 = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)
        let c2 = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: lastReset)
        return c1 == c2 ? freezes : 0
    }

    func momentum14Count(completions: [Date], reference: Date, calendar: Calendar = .current) -> Int {
        guard let start = calendar.date(byAdding: .day, value: -13, to: calendar.startOfDay(for: reference)) else { return 0 }
        return completions.filter { calendar.startOfDay(for: $0) >= start && calendar.startOfDay(for: $0) <= calendar.startOfDay(for: reference) }.count
    }
}
