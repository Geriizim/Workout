import Foundation

enum DeepLinkTarget { case twoMinuteReset, paywall, track(String), unknown }

struct DeepLinkService {
    func parse(_ url: URL) -> DeepLinkTarget {
        let comps = url.pathComponents.filter { $0 != "/" }
        if url.host == "start" && comps.contains("twoMinuteReset") { return .twoMinuteReset }
        if url.host == "paywall" { return .paywall }
        if url.host == "track", let id = comps.last { return .track(id) }
        return .unknown
    }
}
