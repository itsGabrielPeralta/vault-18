import SwiftData
import Foundation

@MainActor
enum PreviewSampleData {

    static let container: ModelContainer = {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(
            for: Child.self, Milestone.self, TimeCapsule.self,
            configurations: config
        )

        // Sample child born 8 months ago
        let birthDate = Calendar.current.date(byAdding: .month, value: -8, to: Date())!
        let child = Child(name: "Luna", birthDate: birthDate)
        container.mainContext.insert(child)

        let milestones = MilestoneGenerator.generateMilestones(for: birthDate)
        for milestone in milestones {
            milestone.child = child
            container.mainContext.insert(milestone)
        }

        // Add a sample capsule to the first milestone
        if let first = milestones.first {
            let capsule = TimeCapsule(text: "El dia mas bonito de nuestras vidas")
            capsule.milestone = first
            container.mainContext.insert(capsule)
        }

        return container
    }()
}
