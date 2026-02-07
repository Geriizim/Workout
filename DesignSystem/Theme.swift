import SwiftUI

enum DS {
    enum Spacing { static let xxs: CGFloat = 4; static let xs: CGFloat = 8; static let sm: CGFloat = 12; static let md: CGFloat = 16; static let lg: CGFloat = 24; static let xl: CGFloat = 32 }
    enum Radius { static let card: CGFloat = 14; static let hero: CGFloat = 18; static let button: CGFloat = 12; static let chip: CGFloat = 10 }
}

enum TrackTheme: String, CaseIterable {
    case office, running, parents, stress, mobility, strength

    var iconName: String {
        switch self {
        case .office: return "figure.mind.and.body"
        case .running: return "figure.run"
        case .parents: return "figure.and.child.holdinghands"
        case .stress: return "brain.head.profile"
        case .mobility: return "figure.flexibility"
        case .strength: return "dumbbell"
        }
    }

    var accent: Color {
        switch self {
        case .office: return .blue
        case .running: return .orange
        case .parents: return .teal
        case .stress: return .purple
        case .mobility: return .mint
        case .strength: return .red
        }
    }

    var gradient: LinearGradient {
        LinearGradient(colors: [accent.opacity(0.25), accent.opacity(0.08)], startPoint: .topLeading, endPoint: .bottomTrailing)
    }

    var todayBackground: some ShapeStyle { gradient }
}
