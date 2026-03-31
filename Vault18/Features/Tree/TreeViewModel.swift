import SwiftUI
import SwiftData

@Observable
final class TreeViewModel {
    let child: Child

    init(child: Child) {
        self.child = child
    }

    var sortedMilestones: [Milestone] {
        child.milestones.sorted { $0.sortOrder < $1.sortOrder }
    }

    var activeMilestone: Milestone? {
        // The most recent available milestone
        sortedMilestones.last(where: { $0.isAvailable })
    }

    var activeMilestoneID: UUID? {
        activeMilestone?.id
    }
}
