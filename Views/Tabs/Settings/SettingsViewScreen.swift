import SwiftUI
import SwiftData

struct SettingsViewScreen: View {
    @Environment(\.modelContext) private var modelContext
    @State private var coachStyle = 0
    @State private var showDeleteConfirm = false
    @State private var showDeleteResult = false
    @State private var deleteResultKey: LocalizedStringKey = "settings.delete.success"

    var body: some View {
        NavigationStack {
            Form {
                Section("settings.notifications") { DatePicker("settings.reminder", selection: .constant(.now), displayedComponents: .hourAndMinute) }
                Section("settings.coach_style") { Picker("settings.coach_style", selection: $coachStyle) { Text("coach.calm").tag(0); Text("coach.energetic").tag(1); Text("coach.minimal").tag(2) } }
                Section("settings.legal") { NavigationLink("settings.privacy") { PrivacyView() }; NavigationLink("settings.terms") { TermsView() }; NavigationLink("settings.data_use") { DataUseView() } }
                Section("settings.data") {
                    Button("settings.delete_all", role: .destructive) { showDeleteConfirm = true }
                }
            }
            .navigationTitle("settings.title")
            .alert("settings.delete.confirm.title", isPresented: $showDeleteConfirm) {
                Button("settings.cancel", role: .cancel) {}
                Button("settings.delete.confirm.cta", role: .destructive) { deleteAllData() }
            } message: {
                Text("settings.delete.confirm.message")
            }
            .alert("", isPresented: $showDeleteResult) {
                Button("settings.ok") {}
            } message: {
                Text(deleteResultKey)
            }
        }
    }

    private func deleteAllData() {
        do {
            try DataResetService().deleteAllData(context: modelContext)
            deleteResultKey = "settings.delete.success"
        } catch {
            deleteResultKey = "settings.delete.failed"
        }
        showDeleteResult = true
    }
}
