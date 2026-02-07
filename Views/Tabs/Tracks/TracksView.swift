import SwiftUI

struct TracksView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [.init(.flexible()), .init(.flexible())], spacing: DS.Spacing.md) {
                    ForEach(TrackTheme.allCases, id: \.self) { theme in
                        NavigationLink(value: theme.rawValue) { TrackCard(title: LocalizedStringKey("track.\(theme.rawValue).name"), subtitle: "track.card.subtitle", theme: theme) }
                    }
                }.padding()
            }
            .navigationDestination(for: String.self) { id in TrackDetailView(trackKey: id) }
            .navigationTitle("tracks.title")
        }
    }
}

struct TrackDetailView: View {
    let trackKey: String
    var body: some View { VStack { Text(LocalizedStringKey("track.\(trackKey).name")); Text("track.detail.starter") } }
}
