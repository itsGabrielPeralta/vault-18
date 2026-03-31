import Foundation

enum MilestoneGenerator {

    static func generateMilestones(for birthDate: Date) -> [Milestone] {
        let cal = Calendar.current
        var milestones: [Milestone] = []

        let specs: [(String, Int, String, DateComponents)] = [
            ("Nacimiento",  0, "birth",    DateComponents()),
            ("Semana 1",    1, "week",     DateComponents(day: 7)),
            ("Mes 1",       2, "month",    DateComponents(month: 1)),
            ("6 Meses",     3, "semester", DateComponents(month: 6)),
        ]

        // Fixed milestones
        for (title, order, type, offset) in specs {
            let date = cal.date(byAdding: offset, to: birthDate) ?? birthDate
            milestones.append(Milestone(title: title, targetDate: date, sortOrder: order, milestoneType: type))
        }

        // Year 1 through Year 18
        for year in 1...18 {
            let date = cal.date(byAdding: .year, value: year, to: birthDate) ?? birthDate
            let title = "Año \(year)"
            milestones.append(Milestone(title: title, targetDate: date, sortOrder: 3 + year, milestoneType: "year"))
        }

        return milestones
    }
}
