import SwiftUI
import SwiftData

@Observable
final class OnboardingViewModel {
    var currentStep: Step = .welcome
    var childName: String = ""
    var birthDate: Date = Date()
    var isCompleted = false

    enum Step: CaseIterable {
        case welcome, name, birthDate
    }

    var isNameValid: Bool {
        !childName.trimmingCharacters(in: .whitespaces).isEmpty
    }

    var dynamicAgeText: String {
        let name = childName.isEmpty ? "tu hijo" : childName
        let comps = Calendar.current.dateComponents([.year, .month, .day], from: birthDate, to: Date())
        let years = comps.year ?? 0
        let months = comps.month ?? 0
        let days = comps.day ?? 0

        if years < 0 || months < 0 || days < 0 {
            return "\(name) aún no ha nacido"
        }

        if years > 0 {
            return "Hoy \(name) tiene \(years) \(years == 1 ? "año" : "años") y \(months) \(months == 1 ? "mes" : "meses")"
        } else if months > 0 {
            return "Hoy \(name) tiene \(months) \(months == 1 ? "mes" : "meses") y \(days) \(days == 1 ? "día" : "días")"
        } else {
            return "Hoy \(name) tiene \(max(days, 0)) \(days == 1 ? "día" : "días")"
        }
    }

    func advance() {
        switch currentStep {
        case .welcome: currentStep = .name
        case .name: currentStep = .birthDate
        case .birthDate: break
        }
    }

    func goBack() {
        switch currentStep {
        case .welcome: break
        case .name: currentStep = .welcome
        case .birthDate: currentStep = .name
        }
    }

    func createChild(context: ModelContext) {
        let child = Child(name: childName.trimmingCharacters(in: .whitespaces), birthDate: birthDate)
        context.insert(child)

        let milestones = MilestoneGenerator.generateMilestones(for: birthDate)
        for milestone in milestones {
            milestone.child = child
            context.insert(milestone)
        }

        isCompleted = true
    }
}
