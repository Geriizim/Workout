import Foundation
import UserNotifications

final class NotificationService {
    private let variants = ["notif.variant1", "notif.variant2", "notif.variant3", "notif.variant4", "notif.variant5"]

    func requestIfNeeded() async -> Bool {
        do { return try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) }
        catch { return false }
    }

    func scheduleDaily(at components: DateComponents) async {
        let content = UNMutableNotificationContent()
        content.title = NSLocalizedString("notif.title", comment: "")
        content.body = NSLocalizedString(variants.randomElement() ?? "notif.variant1", comment: "")
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(identifier: "daily_reminder", content: content, trigger: trigger)
        try? await UNUserNotificationCenter.current().add(request)
    }
}
