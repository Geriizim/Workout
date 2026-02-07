import SwiftUI

struct SettingsViewScreen: View {
    @State private var coachStyle = 0
    var body: some View {
        NavigationStack {
            Form {
                Section("settings.notifications") { DatePicker("settings.reminder", selection: .constant(.now), displayedComponents: .hourAndMinute) }
                Section("settings.coach_style") { Picker("settings.coach_style", selection: $coachStyle) { Text("coach.calm").tag(0); Text("coach.energetic").tag(1); Text("coach.minimal").tag(2) } }
                Section("settings.legal") { NavigationLink("settings.privacy") { PrivacyView() }; NavigationLink("settings.terms") { TermsView() }; NavigationLink("settings.data_use") { DataUseView() } }
            }.navigationTitle("settings.title")
        }
    }
}
