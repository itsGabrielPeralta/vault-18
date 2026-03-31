import SwiftUI
import SwiftData

struct OnboardingView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var vm = OnboardingViewModel()

    var body: some View {
        ZStack {
            Theme.background.ignoresSafeArea()

            Group {
                switch vm.currentStep {
                case .welcome:
                    WelcomeStepView(onContinue: { vm.advance() })
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing).combined(with: .opacity),
                            removal: .move(edge: .leading).combined(with: .opacity)
                        ))

                case .name:
                    ChildNameStepView(
                        name: $vm.childName,
                        isValid: vm.isNameValid,
                        onContinue: { vm.advance() },
                        onBack: { vm.goBack() }
                    )
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing).combined(with: .opacity),
                        removal: .move(edge: .leading).combined(with: .opacity)
                    ))

                case .birthDate:
                    BirthDateStepView(
                        birthDate: $vm.birthDate,
                        childName: vm.childName,
                        ageText: vm.dynamicAgeText,
                        onPlant: { vm.createChild(context: modelContext) },
                        onBack: { vm.goBack() }
                    )
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing).combined(with: .opacity),
                        removal: .move(edge: .leading).combined(with: .opacity)
                    ))
                }
            }
            .animation(.spring(response: 0.45, dampingFraction: 0.85), value: vm.currentStep)
        }
    }
}
