import Foundation
import SwiftData

@Model final class Track { @Attribute(.unique) var stableKey: String; var id: UUID; var nameKey: String; var descriptionKey: String; var iconName: String; var themeKey: String; var sortOrder: Int
    init(id: UUID = UUID(), stableKey: String, nameKey: String, descriptionKey: String, iconName: String, themeKey: String, sortOrder: Int) { self.id = id; self.stableKey = stableKey; self.nameKey = nameKey; self.descriptionKey = descriptionKey; self.iconName = iconName; self.themeKey = themeKey; self.sortOrder = sortOrder }
}
@Model final class Exercise { @Attribute(.unique) var stableKey: String; var id: UUID; var nameKey: String; var descriptionKey: String; var baseDurationSeconds: Int; var tipsKey: String; var iconName: String; var tags: [String]
    init(id: UUID = UUID(), stableKey: String, nameKey: String, descriptionKey: String, baseDurationSeconds: Int, tipsKey: String, iconName: String, tags: [String] = []) { self.id = id; self.stableKey = stableKey; self.nameKey = nameKey; self.descriptionKey = descriptionKey; self.baseDurationSeconds = baseDurationSeconds; self.tipsKey = tipsKey; self.iconName = iconName; self.tags = tags }
}
@Model final class Session { @Attribute(.unique) var stableKey: String; var id: UUID; var trackStableKey: String; var titleKey: String; var level: String; var baseDurationMinutes: Int; var isPro: Bool; var tags: [String]
    init(id: UUID = UUID(), stableKey: String, trackStableKey: String, titleKey: String, level: String, baseDurationMinutes: Int = 8, isPro: Bool, tags: [String]) { self.id = id; self.stableKey = stableKey; self.trackStableKey = trackStableKey; self.titleKey = titleKey; self.level = level; self.baseDurationMinutes = baseDurationMinutes; self.isPro = isPro; self.tags = tags }
}
@Model final class SessionExercise { var id: UUID; var sessionStableKey: String; var exerciseStableKey: String; var order: Int; var baseDurationSeconds: Int
    init(id: UUID = UUID(), sessionStableKey: String, exerciseStableKey: String, order: Int, baseDurationSeconds: Int) { self.id = id; self.sessionStableKey = sessionStableKey; self.exerciseStableKey = exerciseStableKey; self.order = order; self.baseDurationSeconds = baseDurationSeconds }
}
@Model final class CompletedSession { var id: UUID; var sessionStableKey: String; var trackStableKey: String; var date: Date; var durationSeconds: Int; var rating: String
    init(id: UUID = UUID(), sessionStableKey: String, trackStableKey: String, date: Date, durationSeconds: Int, rating: String) { self.id = id; self.sessionStableKey = sessionStableKey; self.trackStableKey = trackStableKey; self.date = date; self.durationSeconds = durationSeconds; self.rating = rating }
}
@Model final class UserProfile { var id: UUID; var primaryTrackStableKey: String; var minutesChoice: Int; var level: String; var equipment: String; var reminderTime: Date; var notificationsEnabled: Bool; var coachStyle: String; var lastTrackStableKeySelected: String; var acceptedSafetyDisclaimer: Bool
    init(id: UUID = UUID(), primaryTrackStableKey: String = "office", minutesChoice: Int = 8, level: String = "beginner", equipment: String = "none", reminderTime: Date = .now, notificationsEnabled: Bool = false, coachStyle: String = "calm", lastTrackStableKeySelected: String = "office", acceptedSafetyDisclaimer: Bool = false) { self.id = id; self.primaryTrackStableKey = primaryTrackStableKey; self.minutesChoice = minutesChoice; self.level = level; self.equipment = equipment; self.reminderTime = reminderTime; self.notificationsEnabled = notificationsEnabled; self.coachStyle = coachStyle; self.lastTrackStableKeySelected = lastTrackStableKeySelected; self.acceptedSafetyDisclaimer = acceptedSafetyDisclaimer }
}
@Model final class StreakState { var id: UUID; var currentStreak: Int; var lastCompletedDate: Date?; var momentum14Count: Int; var freezesUsedThisWeek: Int; var lastFreezeResetDate: Date
    init(id: UUID = UUID(), currentStreak: Int = 0, lastCompletedDate: Date? = nil, momentum14Count: Int = 0, freezesUsedThisWeek: Int = 0, lastFreezeResetDate: Date = .now) { self.id = id; self.currentStreak = currentStreak; self.lastCompletedDate = lastCompletedDate; self.momentum14Count = momentum14Count; self.freezesUsedThisWeek = freezesUsedThisWeek; self.lastFreezeResetDate = lastFreezeResetDate }
}
