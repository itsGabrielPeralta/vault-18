import SwiftData
import Foundation

@Model
final class Milestone {
    var id: UUID
    var title: String
    var targetDate: Date
    var sortOrder: Int
    var milestoneType: String

    var child: Child?

    @Relationship(deleteRule: .cascade, inverse: \TimeCapsule.milestone)
    var capsules: [TimeCapsule]

    var isAvailable: Bool {
        targetDate <= Date()
    }

    var isFilled: Bool {
        !capsules.isEmpty
    }

    var capsuleCount: Int {
        capsules.count
    }

    /// Short label for display on tree nodes
    var shortLabel: String {
        switch milestoneType {
        case "birth": return "Nac"
        case "week": return "1 sem"
        case "month": return "1 mes"
        case "semester": return "6 m"
        case "year":
            let yearNum = sortOrder - 3
            return "\(yearNum) \(yearNum == 1 ? "año" : "años")"
        default: return ""
        }
    }

    init(title: String, targetDate: Date, sortOrder: Int, milestoneType: String) {
        self.id = UUID()
        self.title = title
        self.targetDate = targetDate
        self.sortOrder = sortOrder
        self.milestoneType = milestoneType
        self.capsules = []
    }
}
