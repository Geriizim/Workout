import Foundation
import SwiftData

@MainActor
final class DataResetService {
    func deleteAllData(context: ModelContext) throws {
        try context.delete(model: SessionExercise.self)
        try context.delete(model: Session.self)
        try context.delete(model: Exercise.self)
        try context.delete(model: Track.self)
        try context.delete(model: UserProfile.self)
        try context.delete(model: StreakState.self)
        try context.delete(model: CompletedSession.self)
        try context.save()
    }
}
