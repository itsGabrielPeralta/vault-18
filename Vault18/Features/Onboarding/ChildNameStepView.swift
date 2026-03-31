import SwiftUI

struct ChildNameStepView: View {
    @Binding var name: String
    let isValid: Bool
    let onContinue: () -> Void
    let onBack: () -> Void

    @State private var contentOpacity: Double = 0

    var body: some View {
        VStack(spacing: 0) {
            // Back button
            HStack {
                Button(action: onBack) {
                    Image(systemName: "chevron.left")
                        .font(Theme.rounded(.body, weight: .semibold))
                        .foregroundStyle(Theme.textSecondary)
                }
                Spacer()
            }
            .padding(.horizontal, Theme.spacingL)
            .padding(.top, Theme.spacingM)

            Spacer()

            VStack(spacing: Theme.spacingXL) {
                Text("¿Cómo se llama\ntu semilla?")
                    .font(Theme.titleLarge)
                    .foregroundStyle(Theme.textPrimary)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)

                VaultTextField(placeholder: "Nombre", text: $name)
                    .padding(.horizontal, Theme.spacingXL)

                Text("Puedes cambiarlo después, no te preocupes.")
                    .font(Theme.caption)
                    .foregroundStyle(Theme.textSecondary)
            }

            Spacer()

            if isValid {
                VaultButton(title: "Continuar", style: .primary, action: onContinue)
                    .padding(.horizontal, Theme.spacingL)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }

            Spacer().frame(height: Theme.spacingXXL)
        }
        .opacity(contentOpacity)
        .onAppear {
            withAnimation(.easeOut(duration: 0.35)) {
                contentOpacity = 1
            }
        }
        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: isValid)
    }
}
