import Foundation
import SwiftData

struct SeedExercise {
    let stableKey: String
    let nameKey: String
    let descriptionKey: String
    let tipsKey: String
    let iconName: String
    let baseDurationSeconds: Int
    let tags: [String]
}

struct SeedSession {
    let stableKey: String
    let trackStableKey: String
    let titleKey: String
    let level: String
    let isPro: Bool
    let baseDurationMinutes: Int
    let tags: [String]
    let exerciseKeys: [String]
}

struct ContentSeedService {
    static let contentVersion = 2

    func seedIfNeeded(context: ModelContext) throws {
        try seedTracks(context: context)
        try seedExercises(context: context)
        try seedSessions(context: context)
        try context.save()
    }

    private func seedTracks(context: ModelContext) throws {
        let existing = try Set(context.fetch(FetchDescriptor<Track>()).map(\.stableKey))
        let tracks: [(String,String,String,String)] = [
            ("office","track.office.name","track.office.desc","office"),
            ("running","track.running.name","track.running.desc","running"),
            ("parents","track.parents.name","track.parents.desc","parents"),
            ("stress","track.stress.name","track.stress.desc","stress"),
            ("mobility","track.mobility.name","track.mobility.desc","mobility"),
            ("strength","track.strength.name","track.strength.desc","strength")
        ]
        for (idx,t) in tracks.enumerated() where !existing.contains(t.0) {
            context.insert(Track(stableKey: t.0, nameKey: t.1, descriptionKey: t.2, iconName: TrackTheme(rawValue: t.3)?.iconName ?? "figure.walk", themeKey: t.3, sortOrder: idx))
        }
    }

    private func seedExercises(context: ModelContext) throws {
        let existing = try Set(context.fetch(FetchDescriptor<Exercise>()).map(\.stableKey))
        for exercise in Self.exercises where !existing.contains(exercise.stableKey) {
            context.insert(Exercise(stableKey: exercise.stableKey, nameKey: exercise.nameKey, descriptionKey: exercise.descriptionKey, baseDurationSeconds: exercise.baseDurationSeconds, tipsKey: exercise.tipsKey, iconName: exercise.iconName, tags: exercise.tags))
        }
    }

    private func seedSessions(context: ModelContext) throws {
        let existingSessions = try Set(context.fetch(FetchDescriptor<Session>()).map(\.stableKey))
        let existingLinks = try Set(context.fetch(FetchDescriptor<SessionExercise>()).map { "\($0.sessionStableKey)|\($0.exerciseStableKey)" })

        for session in Self.sessions where !existingSessions.contains(session.stableKey) {
            context.insert(Session(stableKey: session.stableKey, trackStableKey: session.trackStableKey, titleKey: session.titleKey, level: session.level, baseDurationMinutes: session.baseDurationMinutes, isPro: session.isPro, tags: session.tags))
        }

        for session in Self.sessions {
            for (idx, key) in session.exerciseKeys.enumerated() {
                let compound = "\(session.stableKey)|\(key)"
                if existingLinks.contains(compound) { continue }
                context.insert(SessionExercise(sessionStableKey: session.stableKey, exerciseStableKey: key, order: idx, baseDurationSeconds: 45))
            }
        }

    }

    static func mergedStableKeys(existing: Set<String>, incoming: [String]) -> [String] {
        incoming.filter { !existing.contains($0) }
    }

    static let exercises: [SeedExercise] = [
        .init(stableKey: "office_chin_tuck", nameKey: "exercise.office_chin_tuck.name", descriptionKey: "exercise.office_chin_tuck.desc", tipsKey: "exercise.office_chin_tuck.tips", iconName: "person.crop.circle", baseDurationSeconds: 40, tags: ["desk", "mobility", "noFloor", "lowImpact"]),
        .init(stableKey: "office_neck_rotation", nameKey: "exercise.office_neck_rotation.name", descriptionKey: "exercise.office_neck_rotation.desc", tipsKey: "exercise.office_neck_rotation.tips", iconName: "arrow.left.and.right.circle", baseDurationSeconds: 40, tags: ["desk", "mobility", "noFloor", "lowImpact"]),
        .init(stableKey: "office_neck_side_bend", nameKey: "exercise.office_neck_side_bend.name", descriptionKey: "exercise.office_neck_side_bend.desc", tipsKey: "exercise.office_neck_side_bend.tips", iconName: "arrow.up.and.down.circle", baseDurationSeconds: 40, tags: ["desk", "mobility", "noFloor", "lowImpact"]),
        .init(stableKey: "office_levator_stretch", nameKey: "exercise.office_levator_stretch.name", descriptionKey: "exercise.office_levator_stretch.desc", tipsKey: "exercise.office_levator_stretch.tips", iconName: "figure.cooldown", baseDurationSeconds: 40, tags: ["desk", "mobility", "noFloor", "lowImpact"]),
        .init(stableKey: "office_scap_squeeze", nameKey: "exercise.office_scap_squeeze.name", descriptionKey: "exercise.office_scap_squeeze.desc", tipsKey: "exercise.office_scap_squeeze.tips", iconName: "shoulder.left", baseDurationSeconds: 45, tags: ["desk", "strength", "noFloor", "lowImpact"]),
        .init(stableKey: "office_wall_angel", nameKey: "exercise.office_wall_angel.name", descriptionKey: "exercise.office_wall_angel.desc", tipsKey: "exercise.office_wall_angel.tips", iconName: "figure.arms.open", baseDurationSeconds: 50, tags: ["desk", "mobility", "noFloor", "lowImpact"]),
        .init(stableKey: "office_doorway_pec", nameKey: "exercise.office_doorway_pec.name", descriptionKey: "exercise.office_doorway_pec.desc", tipsKey: "exercise.office_doorway_pec.tips", iconName: "door.left.hand.open", baseDurationSeconds: 40, tags: ["desk", "mobility", "noFloor", "lowImpact"]),
        .init(stableKey: "office_cat_cow", nameKey: "exercise.office_cat_cow.name", descriptionKey: "exercise.office_cat_cow.desc", tipsKey: "exercise.office_cat_cow.tips", iconName: "figure.yoga", baseDurationSeconds: 50, tags: ["desk", "mobility", "lowImpact"]),
        .init(stableKey: "office_thread_needle", nameKey: "exercise.office_thread_needle.name", descriptionKey: "exercise.office_thread_needle.desc", tipsKey: "exercise.office_thread_needle.tips", iconName: "arrow.triangle.2.circlepath", baseDurationSeconds: 50, tags: ["desk", "mobility", "lowImpact"]),
        .init(stableKey: "office_wrist_extensor", nameKey: "exercise.office_wrist_extensor.name", descriptionKey: "exercise.office_wrist_extensor.desc", tipsKey: "exercise.office_wrist_extensor.tips", iconName: "hand.raised", baseDurationSeconds: 40, tags: ["desk", "mobility", "noFloor", "lowImpact"]),
        .init(stableKey: "parent_march_in_place", nameKey: "exercise.parent_march_in_place.name", descriptionKey: "exercise.parent_march_in_place.desc", tipsKey: "exercise.parent_march_in_place.tips", iconName: "figure.walk", baseDurationSeconds: 55, tags: ["parents", "lowImpact", "noFloor"]),
        .init(stableKey: "parent_sit_to_stand", nameKey: "exercise.parent_sit_to_stand.name", descriptionKey: "exercise.parent_sit_to_stand.desc", tipsKey: "exercise.parent_sit_to_stand.tips", iconName: "chair", baseDurationSeconds: 55, tags: ["parents", "strength", "lowImpact", "noFloor"]),
        .init(stableKey: "parent_counter_pushup", nameKey: "exercise.parent_counter_pushup.name", descriptionKey: "exercise.parent_counter_pushup.desc", tipsKey: "exercise.parent_counter_pushup.tips", iconName: "figure.strengthtraining.traditional", baseDurationSeconds: 55, tags: ["parents", "strength", "noFloor"]),
        .init(stableKey: "parent_glute_bridge", nameKey: "exercise.parent_glute_bridge.name", descriptionKey: "exercise.parent_glute_bridge.desc", tipsKey: "exercise.parent_glute_bridge.tips", iconName: "figure.strengthtraining.functional", baseDurationSeconds: 55, tags: ["parents", "strength", "lowImpact"]),
        .init(stableKey: "parent_dead_bug", nameKey: "exercise.parent_dead_bug.name", descriptionKey: "exercise.parent_dead_bug.desc", tipsKey: "exercise.parent_dead_bug.tips", iconName: "figure.core.training", baseDurationSeconds: 55, tags: ["parents", "strength", "lowImpact"]),
        .init(stableKey: "parent_side_plank_knees", nameKey: "exercise.parent_side_plank_knees.name", descriptionKey: "exercise.parent_side_plank_knees.desc", tipsKey: "exercise.parent_side_plank_knees.tips", iconName: "figure.mixed.cardio", baseDurationSeconds: 40, tags: ["parents", "strength", "lowImpact"]),
        .init(stableKey: "parent_calf_raises", nameKey: "exercise.parent_calf_raises.name", descriptionKey: "exercise.parent_calf_raises.desc", tipsKey: "exercise.parent_calf_raises.tips", iconName: "figure.stand", baseDurationSeconds: 55, tags: ["parents", "strength", "running", "lowImpact", "noFloor"]),
        .init(stableKey: "parent_breath_reset", nameKey: "exercise.parent_breath_reset.name", descriptionKey: "exercise.parent_breath_reset.desc", tipsKey: "exercise.parent_breath_reset.tips", iconName: "lungs", baseDurationSeconds: 70, tags: ["parents", "stress", "lowImpact", "noFloor"]),
        .init(stableKey: "parent_hip_flexor_stretch", nameKey: "exercise.parent_hip_flexor_stretch.name", descriptionKey: "exercise.parent_hip_flexor_stretch.desc", tipsKey: "exercise.parent_hip_flexor_stretch.tips", iconName: "figure.lunge", baseDurationSeconds: 40, tags: ["parents", "mobility", "lowImpact"]),
        .init(stableKey: "run_single_leg_balance", nameKey: "exercise.run_single_leg_balance.name", descriptionKey: "exercise.run_single_leg_balance.desc", tipsKey: "exercise.run_single_leg_balance.tips", iconName: "figure.stand.line.dotted.figure.stand", baseDurationSeconds: 40, tags: ["running", "strength", "lowImpact", "noFloor"]),
        .init(stableKey: "run_tibialis_raises", nameKey: "exercise.run_tibialis_raises.name", descriptionKey: "exercise.run_tibialis_raises.desc", tipsKey: "exercise.run_tibialis_raises.tips", iconName: "figure.walk.motion", baseDurationSeconds: 55, tags: ["running", "strength", "lowImpact", "noFloor"]),
        .init(stableKey: "run_single_leg_rdl", nameKey: "exercise.run_single_leg_rdl.name", descriptionKey: "exercise.run_single_leg_rdl.desc", tipsKey: "exercise.run_single_leg_rdl.tips", iconName: "figure.step.training", baseDurationSeconds: 40, tags: ["running", "strength", "noFloor"]),
        .init(stableKey: "run_clamshell", nameKey: "exercise.run_clamshell.name", descriptionKey: "exercise.run_clamshell.desc", tipsKey: "exercise.run_clamshell.tips", iconName: "figure.flexibility", baseDurationSeconds: 50, tags: ["running", "strength", "lowImpact"]),
        .init(stableKey: "run_lateral_band_walk", nameKey: "exercise.run_lateral_band_walk.name", descriptionKey: "exercise.run_lateral_band_walk.desc", tipsKey: "exercise.run_lateral_band_walk.tips", iconName: "figure.run.square.stack", baseDurationSeconds: 55, tags: ["running", "strength", "noFloor"]),
        .init(stableKey: "run_step_down", nameKey: "exercise.run_step_down.name", descriptionKey: "exercise.run_step_down.desc", tipsKey: "exercise.run_step_down.tips", iconName: "figure.stairs", baseDurationSeconds: 40, tags: ["running", "strength", "noFloor"]),
        .init(stableKey: "run_split_squat", nameKey: "exercise.run_split_squat.name", descriptionKey: "exercise.run_split_squat.desc", tipsKey: "exercise.run_split_squat.tips", iconName: "figure.strengthtraining.functional", baseDurationSeconds: 55, tags: ["running", "strength", "noFloor"]),
        .init(stableKey: "run_ankle_mobility", nameKey: "exercise.run_ankle_mobility.name", descriptionKey: "exercise.run_ankle_mobility.desc", tipsKey: "exercise.run_ankle_mobility.tips", iconName: "figure.walk.arrival", baseDurationSeconds: 55, tags: ["running", "mobility", "lowImpact", "noFloor"]),
        .init(stableKey: "run_calf_eccentric", nameKey: "exercise.run_calf_eccentric.name", descriptionKey: "exercise.run_calf_eccentric.desc", tipsKey: "exercise.run_calf_eccentric.tips", iconName: "figure.cooldown", baseDurationSeconds: 55, tags: ["running", "strength", "lowImpact", "noFloor"]),
        .init(stableKey: "stress_box_breathing", nameKey: "exercise.stress_box_breathing.name", descriptionKey: "exercise.stress_box_breathing.desc", tipsKey: "exercise.stress_box_breathing.tips", iconName: "square.grid.2x2", baseDurationSeconds: 90, tags: ["stress", "lowImpact", "noFloor"]),
        .init(stableKey: "stress_body_scan", nameKey: "exercise.stress_body_scan.name", descriptionKey: "exercise.stress_body_scan.desc", tipsKey: "exercise.stress_body_scan.tips", iconName: "waveform.path.ecg", baseDurationSeconds: 100, tags: ["stress", "lowImpact", "noFloor"]),
        .init(stableKey: "stress_shoulder_rolls", nameKey: "exercise.stress_shoulder_rolls.name", descriptionKey: "exercise.stress_shoulder_rolls.desc", tipsKey: "exercise.stress_shoulder_rolls.tips", iconName: "arrow.trianglehead.2.clockwise.rotate.90", baseDurationSeconds: 55, tags: ["stress", "desk", "lowImpact", "noFloor"]),
        .init(stableKey: "stress_neck_release", nameKey: "exercise.stress_neck_release.name", descriptionKey: "exercise.stress_neck_release.desc", tipsKey: "exercise.stress_neck_release.tips", iconName: "face.smiling", baseDurationSeconds: 55, tags: ["stress", "desk", "lowImpact", "noFloor"]),
        .init(stableKey: "stress_forward_fold", nameKey: "exercise.stress_forward_fold.name", descriptionKey: "exercise.stress_forward_fold.desc", tipsKey: "exercise.stress_forward_fold.tips", iconName: "figure.fall", baseDurationSeconds: 55, tags: ["stress", "mobility", "lowImpact", "noFloor"]),
        .init(stableKey: "stress_child_pose", nameKey: "exercise.stress_child_pose.name", descriptionKey: "exercise.stress_child_pose.desc", tipsKey: "exercise.stress_child_pose.tips", iconName: "moon.zzz", baseDurationSeconds: 70, tags: ["stress", "mobility", "lowImpact"]),
        .init(stableKey: "mob_worlds_greatest", nameKey: "exercise.mob_worlds_greatest.name", descriptionKey: "exercise.mob_worlds_greatest.desc", tipsKey: "exercise.mob_worlds_greatest.tips", iconName: "globe", baseDurationSeconds: 70, tags: ["mobility", "lowImpact"]),
        .init(stableKey: "mob_90_90", nameKey: "exercise.mob_90_90.name", descriptionKey: "exercise.mob_90_90.desc", tipsKey: "exercise.mob_90_90.tips", iconName: "arrow.left.arrow.right", baseDurationSeconds: 70, tags: ["mobility", "lowImpact"]),
        .init(stableKey: "mob_hamstring", nameKey: "exercise.mob_hamstring.name", descriptionKey: "exercise.mob_hamstring.desc", tipsKey: "exercise.mob_hamstring.tips", iconName: "bolt.heart", baseDurationSeconds: 40, tags: ["mobility", "lowImpact"]),
        .init(stableKey: "mob_glute_piriformis", nameKey: "exercise.mob_glute_piriformis.name", descriptionKey: "exercise.mob_glute_piriformis.desc", tipsKey: "exercise.mob_glute_piriformis.tips", iconName: "figure.seated.side", baseDurationSeconds: 40, tags: ["mobility", "lowImpact"]),
        .init(stableKey: "mob_spine_twist", nameKey: "exercise.mob_spine_twist.name", descriptionKey: "exercise.mob_spine_twist.desc", tipsKey: "exercise.mob_spine_twist.tips", iconName: "arrow.uturn.left.circle", baseDurationSeconds: 50, tags: ["mobility", "stress", "lowImpact"]),
        .init(stableKey: "mob_couch_stretch", nameKey: "exercise.mob_couch_stretch.name", descriptionKey: "exercise.mob_couch_stretch.desc", tipsKey: "exercise.mob_couch_stretch.tips", iconName: "sofa", baseDurationSeconds: 40, tags: ["mobility", "lowImpact"])
    ]

    static let sessions: [SeedSession] = [
        .init(stableKey: "office_session_1", trackStableKey: "office", titleKey: "session.office_session_1.title", level: "beginner", isPro: false, baseDurationMinutes: 8, tags: ["free", "starter", "noFloor", "lowImpact"], exerciseKeys: ["office_chin_tuck","office_neck_rotation","office_scap_squeeze","office_doorway_pec"]),
        .init(stableKey: "office_session_2", trackStableKey: "office", titleKey: "session.office_session_2.title", level: "beginner", isPro: false, baseDurationMinutes: 8, tags: ["free", "starter", "lowImpact"], exerciseKeys: ["office_cat_cow","office_thread_needle","office_wall_angel","office_wrist_extensor"]),
        .init(stableKey: "office_session_3", trackStableKey: "office", titleKey: "session.office_session_3.title", level: "beginner", isPro: false, baseDurationMinutes: 8, tags: ["free", "starter", "noFloor", "lowImpact"], exerciseKeys: ["office_levator_stretch","office_neck_side_bend","office_scap_squeeze","stress_box_breathing"]),
        .init(stableKey: "office_session_4", trackStableKey: "office", titleKey: "session.office_session_4.title", level: "intermediate", isPro: true, baseDurationMinutes: 8, tags: ["pro", "desk", "noFloor"], exerciseKeys: ["office_wall_angel","office_thread_needle","run_tibialis_raises","office_doorway_pec"]),
        .init(stableKey: "office_session_5", trackStableKey: "office", titleKey: "session.office_session_5.title", level: "intermediate", isPro: true, baseDurationMinutes: 8, tags: ["pro", "desk", "lowImpact"], exerciseKeys: ["office_cat_cow","mob_spine_twist","office_wrist_extensor","stress_body_scan"]),

        .init(stableKey: "running_session_1", trackStableKey: "running", titleKey: "session.running_session_1.title", level: "beginner", isPro: false, baseDurationMinutes: 8, tags: ["free", "starter", "noFloor", "lowImpact"], exerciseKeys: ["run_single_leg_balance","run_tibialis_raises","run_ankle_mobility","run_calf_eccentric"]),
        .init(stableKey: "running_session_2", trackStableKey: "running", titleKey: "session.running_session_2.title", level: "beginner", isPro: false, baseDurationMinutes: 8, tags: ["free", "starter", "noFloor"], exerciseKeys: ["run_split_squat","run_step_down","run_single_leg_rdl","run_lateral_band_walk"]),
        .init(stableKey: "running_session_3", trackStableKey: "running", titleKey: "session.running_session_3.title", level: "beginner", isPro: false, baseDurationMinutes: 8, tags: ["free", "starter", "lowImpact"], exerciseKeys: ["run_clamshell","run_ankle_mobility","parent_calf_raises","stress_box_breathing"]),
        .init(stableKey: "running_session_4", trackStableKey: "running", titleKey: "session.running_session_4.title", level: "intermediate", isPro: true, baseDurationMinutes: 8, tags: ["pro", "noFloor"], exerciseKeys: ["run_split_squat","run_single_leg_rdl","run_step_down","run_tibialis_raises"]),
        .init(stableKey: "running_session_5", trackStableKey: "running", titleKey: "session.running_session_5.title", level: "intermediate", isPro: true, baseDurationMinutes: 8, tags: ["pro", "lowImpact"], exerciseKeys: ["run_calf_eccentric","run_ankle_mobility","mob_hamstring","stress_body_scan"]),

        .init(stableKey: "parents_session_1", trackStableKey: "parents", titleKey: "session.parents_session_1.title", level: "beginner", isPro: false, baseDurationMinutes: 8, tags: ["free", "starter", "noFloor", "lowImpact"], exerciseKeys: ["parent_march_in_place","parent_sit_to_stand","parent_counter_pushup","parent_breath_reset"]),
        .init(stableKey: "parents_session_2", trackStableKey: "parents", titleKey: "session.parents_session_2.title", level: "beginner", isPro: false, baseDurationMinutes: 8, tags: ["free", "starter", "lowImpact"], exerciseKeys: ["parent_glute_bridge","parent_dead_bug","parent_side_plank_knees","parent_hip_flexor_stretch"]),
        .init(stableKey: "parents_session_3", trackStableKey: "parents", titleKey: "session.parents_session_3.title", level: "beginner", isPro: false, baseDurationMinutes: 8, tags: ["free", "starter", "noFloor", "lowImpact"], exerciseKeys: ["parent_march_in_place","parent_calf_raises","stress_shoulder_rolls","stress_box_breathing"]),
        .init(stableKey: "parents_session_4", trackStableKey: "parents", titleKey: "session.parents_session_4.title", level: "intermediate", isPro: true, baseDurationMinutes: 8, tags: ["pro", "noFloor"], exerciseKeys: ["parent_sit_to_stand","parent_counter_pushup","run_split_squat","parent_calf_raises"]),
        .init(stableKey: "parents_session_5", trackStableKey: "parents", titleKey: "session.parents_session_5.title", level: "intermediate", isPro: true, baseDurationMinutes: 8, tags: ["pro", "lowImpact"], exerciseKeys: ["parent_glute_bridge","parent_dead_bug","parent_hip_flexor_stretch","stress_body_scan"]),

        .init(stableKey: "stress_session_1", trackStableKey: "stress", titleKey: "session.stress_session_1.title", level: "beginner", isPro: false, baseDurationMinutes: 8, tags: ["free", "starter", "noFloor", "lowImpact"], exerciseKeys: ["stress_box_breathing","stress_shoulder_rolls","stress_neck_release","parent_breath_reset"]),
        .init(stableKey: "stress_session_2", trackStableKey: "stress", titleKey: "session.stress_session_2.title", level: "beginner", isPro: false, baseDurationMinutes: 8, tags: ["free", "starter", "lowImpact"], exerciseKeys: ["stress_body_scan","stress_child_pose","mob_spine_twist","stress_forward_fold"]),
        .init(stableKey: "stress_session_3", trackStableKey: "stress", titleKey: "session.stress_session_3.title", level: "beginner", isPro: false, baseDurationMinutes: 8, tags: ["free", "starter", "noFloor", "lowImpact"], exerciseKeys: ["stress_box_breathing","office_neck_rotation","stress_shoulder_rolls","stress_body_scan"]),
        .init(stableKey: "stress_session_4", trackStableKey: "stress", titleKey: "session.stress_session_4.title", level: "intermediate", isPro: true, baseDurationMinutes: 8, tags: ["pro", "lowImpact"], exerciseKeys: ["stress_body_scan","stress_child_pose","stress_forward_fold","mob_90_90"]),
        .init(stableKey: "stress_session_5", trackStableKey: "stress", titleKey: "session.stress_session_5.title", level: "intermediate", isPro: true, baseDurationMinutes: 8, tags: ["pro", "noFloor", "lowImpact"], exerciseKeys: ["stress_box_breathing","parent_breath_reset","stress_neck_release","stress_shoulder_rolls"]),

        .init(stableKey: "mobility_session_1", trackStableKey: "mobility", titleKey: "session.mobility_session_1.title", level: "beginner", isPro: false, baseDurationMinutes: 8, tags: ["free", "starter", "lowImpact"], exerciseKeys: ["mob_worlds_greatest","mob_90_90","mob_hamstring","mob_spine_twist"]),
        .init(stableKey: "mobility_session_2", trackStableKey: "mobility", titleKey: "session.mobility_session_2.title", level: "beginner", isPro: false, baseDurationMinutes: 8, tags: ["free", "starter", "lowImpact", "noFloor"], exerciseKeys: ["run_ankle_mobility","office_wall_angel","office_doorway_pec","stress_box_breathing"]),
        .init(stableKey: "mobility_session_3", trackStableKey: "mobility", titleKey: "session.mobility_session_3.title", level: "beginner", isPro: false, baseDurationMinutes: 8, tags: ["free", "starter", "lowImpact"], exerciseKeys: ["mob_glute_piriformis","mob_hamstring","mob_couch_stretch","stress_child_pose"]),
        .init(stableKey: "mobility_session_4", trackStableKey: "mobility", titleKey: "session.mobility_session_4.title", level: "intermediate", isPro: true, baseDurationMinutes: 8, tags: ["pro", "lowImpact"], exerciseKeys: ["mob_worlds_greatest","mob_90_90","mob_couch_stretch","run_single_leg_rdl"]),
        .init(stableKey: "mobility_session_5", trackStableKey: "mobility", titleKey: "session.mobility_session_5.title", level: "intermediate", isPro: true, baseDurationMinutes: 8, tags: ["pro", "noFloor", "lowImpact"], exerciseKeys: ["office_neck_side_bend","office_wrist_extensor","run_ankle_mobility","stress_body_scan"]),

        .init(stableKey: "strength_session_1", trackStableKey: "strength", titleKey: "session.strength_session_1.title", level: "beginner", isPro: false, baseDurationMinutes: 8, tags: ["free", "starter", "noFloor", "lowImpact"], exerciseKeys: ["parent_sit_to_stand","parent_counter_pushup","parent_calf_raises","run_single_leg_balance"]),
        .init(stableKey: "strength_session_2", trackStableKey: "strength", titleKey: "session.strength_session_2.title", level: "beginner", isPro: false, baseDurationMinutes: 8, tags: ["free", "starter", "lowImpact"], exerciseKeys: ["parent_glute_bridge","parent_dead_bug","parent_side_plank_knees","run_clamshell"]),
        .init(stableKey: "strength_session_3", trackStableKey: "strength", titleKey: "session.strength_session_3.title", level: "beginner", isPro: false, baseDurationMinutes: 8, tags: ["free", "starter", "noFloor", "lowImpact"], exerciseKeys: ["run_tibialis_raises","parent_march_in_place","office_scap_squeeze","stress_box_breathing"]),
        .init(stableKey: "strength_session_4", trackStableKey: "strength", titleKey: "session.strength_session_4.title", level: "intermediate", isPro: true, baseDurationMinutes: 8, tags: ["pro", "noFloor"], exerciseKeys: ["run_split_squat","run_lateral_band_walk","run_step_down","parent_counter_pushup"]),
        .init(stableKey: "strength_session_5", trackStableKey: "strength", titleKey: "session.strength_session_5.title", level: "intermediate", isPro: true, baseDurationMinutes: 8, tags: ["pro", "lowImpact"], exerciseKeys: ["parent_glute_bridge","run_calf_eccentric","mob_hamstring","stress_body_scan"]),
        .init(stableKey: "two_min_reset", trackStableKey: "stress", titleKey: "session.two_min_reset.title", level: "beginner", isPro: false, baseDurationMinutes: 2, tags: ["2min", "free", "noFloor", "lowImpact"], exerciseKeys: ["stress_box_breathing", "stress_neck_release", "stress_shoulder_rolls"])
    ]
}
