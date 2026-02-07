import SwiftUI
import SwiftData

@main
struct MicroStreaksApp: App {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @AppStorage("seededContentVersion") private var seededContentVersion = 0

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Track.self, Exercise.self, Session.self, SessionExercise.self,
            CompletedSession.self, UserProfile.self, StreakState.self
        ])
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do { return try ModelContainer(for: schema, configurations: [config]) }
        catch {
            fatalError("ModelContainer failed: \(error.localizedDescription)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            RootView(hasCompletedOnboarding: $hasCompletedOnboarding)
                .preferredColorScheme(nil)
                .onAppear {
                    initializeSeededDataIfNeeded()
                }
        }
        .modelContainer(sharedModelContainer)
    }

    private func initializeSeededDataIfNeeded() {
        let currentVersion = ContentSeedService.contentVersion
        let versioningService = ContentVersioningService()
        guard versioningService.shouldApply(currentVersion: currentVersion, seededVersion: seededContentVersion) else { return }

        let context = ModelContext(sharedModelContainer)
        do {
            try ContentSeedService().seedIfNeeded(context: context)
            versioningService.applyIfNeeded(currentVersion: currentVersion, seededVersion: seededContentVersion)
        } catch {
            EventLogger.log("content_seed_failed", meta: ["reason": error.localizedDescription])
        }
    }
}

struct RootView: View {
    @Binding var hasCompletedOnboarding: Bool

    var body: some View {
        Group {
            if hasCompletedOnboarding {
                MainTabView()
            } else {
                OnboardingFlowView(onFinish: { hasCompletedOnboarding = true })
            }
        }
    }
}
