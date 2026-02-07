import Foundation

struct SessionScalingService {
    func scaledDurations(baseDurations: [Int], targetMinutes: Int) -> [Int] {
        let factor = Double(targetMinutes) / 8.0
        var scaled = baseDurations.map { min(90, max(20, Int((Double($0) * factor).rounded()))) }
        let target = targetMinutes * 60
        var delta = target - scaled.reduce(0,+)
        var guardCounter = 0
        while abs(delta) > 10 && guardCounter < 5_000 && !scaled.isEmpty {
            var changed = false
            for idx in scaled.indices {
                if delta > 0, scaled[idx] < 90 { scaled[idx] += 1; delta -= 1; changed = true }
                else if delta < 0, scaled[idx] > 20 { scaled[idx] -= 1; delta += 1; changed = true }
                if abs(delta) <= 10 { break }
            }
            if !changed { break }
            guardCounter += 1
        }
        return scaled
    }
}
