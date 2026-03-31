import SwiftUI

struct BirthDateStepView: View {
    @Binding var birthDate: Date
    let childName: String
    let ageText: String
    let onPlant: () -> Void
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

            Spacer().frame(height: Theme.spacingXL)

            Text("¿Cuándo nació\n\(childName)?")
                .font(Theme.titleLarge)
                .foregroundStyle(Theme.textPrimary)
                .multilineTextAlignment(.center)
                .lineSpacing(4)

            Spacer().frame(height: Theme.spacingL)

            // Age indicator
            Text(ageText)
                .font(Theme.bodyBold)
                .foregroundStyle(Theme.primary)
                .padding(.horizontal, Theme.spacingM)
                .padding(.vertical, Theme.spacingS)
                .background(Theme.primary.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: Theme.radiusS))
                .animation(.easeInOut(duration: 0.2), value: ageText)

            Spacer().frame(height: Theme.spacingL)

            DatePicker(
                "",
                selection: $birthDate,
                in: ...Date(),
                displayedComponents: .date
            )
            .datePickerStyle(.wheel)
            .labelsHidden()
            .tint(Theme.primary)
            .padding(.horizontal, Theme.spacingM)

            Spacer()

            VaultButton(
                title: "Plantar el árbol de \(childName)",
                style: .primary,
                action: onPlant
            )
            .padding(.horizontal, Theme.spacingL)

            Spacer().frame(height: Theme.spacingXXL)
        }
        .opacity(contentOpacity)
        .onAppear {
            withAnimation(.easeOut(duration: 0.35)) {
                contentOpacity = 1
            }
        }
    }
}
