import WidgetKit
import SwiftUI

struct MicroEntry: TimelineEntry { let date: Date; let momentumText: String }

struct MicroProvider: TimelineProvider {
    func placeholder(in context: Context) -> MicroEntry { .init(date: .now, momentumText: "6/14") }
    func getSnapshot(in context: Context, completion: @escaping (MicroEntry) -> Void) { completion(.init(date: .now, momentumText: "6/14")) }
    func getTimeline(in context: Context, completion: @escaping (Timeline<MicroEntry>) -> Void) {
        completion(Timeline(entries: [.init(date: .now, momentumText: "6/14")], policy: .after(.now.addingTimeInterval(3600))))
    }
}

struct MicroWidgetView: View {
    var entry: MicroProvider.Entry
    var body: some View { VStack { Text("widget.momentum"); Text(entry.momentumText).font(.title2.bold()); Link("widget.start_reset", destination: URL(string: "microstreaks://start/twoMinuteReset")!) } }
}

struct MicroStreaksWidget: Widget {
    let kind: String = "MicroStreaksWidget"
    var body: some WidgetConfiguration { StaticConfiguration(kind: kind, provider: MicroProvider()) { MicroWidgetView(entry: $0) }.supportedFamilies([.systemSmall]).configurationDisplayName("MicroStreaks") }
}
