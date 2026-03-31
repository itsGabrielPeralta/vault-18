import SwiftData
import Foundation

@Model
final class Child {
    var id: UUID
    var name: String
    var birthDate: Date
    var createdAt: Date

    @Relationship(deleteRule: .cascade, inverse: \Milestone.child)
    var milestones: [Milestone]

    var releaseDate: Date {
        Calendar.current.date(byAdding: .year, value: 18, to: birthDate) ?? birthDate
    }

    var ageInMonths: Int {
        let components = Calendar.current.dateComponents([.month], from: birthDate, to: Date())
        return components.month ?? 0
    }

    var ageDescription: String {
        let comps = Calendar.current.dateComponents([.year, .month, .day], from: birthDate, to: Date())
        let years = comps.year ?? 0
        let months = comps.month ?? 0
        let days = comps.day ?? 0

        if years > 0 {
            if months > 0 {
                return "\(years) \(years == 1 ? "año" : "años") y \(months) \(months == 1 ? "mes" : "meses")"
            }
            return "\(years) \(years == 1 ? "año" : "años")"
        } else if months > 0 {
            if days > 0 {
                return "\(months) \(months == 1 ? "mes" : "meses") y \(days) \(days == 1 ? "día" : "días")"
            }
            return "\(months) \(months == 1 ? "mes" : "meses")"
        } else {
            return "\(max(days, 0)) \(days == 1 ? "día" : "días")"
        }
    }

    init(name: String, birthDate: Date) {
        self.id = UUID()
        self.name = name
        self.birthDate = birthDate
        self.createdAt = Date()
        self.milestones = []
    }
}
