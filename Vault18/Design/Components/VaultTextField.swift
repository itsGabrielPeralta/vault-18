import SwiftUI

struct VaultTextField: View {
    let placeholder: String
    @Binding var text: String
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TextField("", text: $text, prompt: promptText)
                .font(Theme.rounded(.title2, weight: .medium))
                .foregroundStyle(Theme.textPrimary)
                .focused($isFocused)
                .textInputAutocapitalization(.words)
                .autocorrectionDisabled()

            Rectangle()
                .fill(isFocused ? Theme.natural : Theme.marronClaro.opacity(0.4))
                .frame(height: isFocused ? 2.5 : 1.5)
                .padding(.top, Theme.spacingS)
                .animation(.easeInOut(duration: 0.25), value: isFocused)
        }
        .onAppear {
            isFocused = true
        }
    }

    private var promptText: Text {
        Text(placeholder)
            .foregroundStyle(Theme.textSecondary.opacity(0.6))
    }
}
