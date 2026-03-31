import SwiftUI
import SwiftData

@main
struct Vault18App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Child.self, Milestone.self, TimeCapsule.self])
    }
}
