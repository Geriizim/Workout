import Foundation

enum EventLogger {
    static func log(_ event: String, meta: [String: String] = [:]) { print("[MicroStreaks] \(event) \(meta)") }
}
