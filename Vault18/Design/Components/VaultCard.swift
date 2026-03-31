import SwiftUI

struct VaultCard<Content: View>: View {
    @ViewBuilder let content: () -> Content

    var body: some View {
        content()
            .padding(Theme.spacingM)
            .background(Theme.surface)
            .clipShape(RoundedRectangle(cornerRadius: Theme.radiusM))
            .overlay {
                RoundedRectangle(cornerRadius: Theme.radiusM)
                    .strokeBorder(Theme.marronClaro.opacity(0.12), lineWidth: 1)
            }
    }
}
