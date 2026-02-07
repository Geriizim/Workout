import Foundation

struct ExportService {
    func csv(completed: [CompletedSession]) -> String {
        var lines = ["date,track,session,minutes"]
        let df = ISO8601DateFormatter()
        completed.forEach { lines.append("\(df.string(from: $0.date)),\($0.trackStableKey),\($0.sessionStableKey),\($0.durationSeconds/60)") }
        return lines.joined(separator: "\n")
    }
}
