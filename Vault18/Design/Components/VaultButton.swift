import SwiftUI

struct VaultButton: View {
    let title: String
    let style: Style
    let action: () -> Void

    enum Style {
        case primary
        case secondary
        case text
    }

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(Theme.bodyBold)
                .foregroundStyle(foregroundColor)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: Theme.radiusM))
                .overlay {
                    if style == .secondary {
                        RoundedRectangle(cornerRadius: Theme.radiusM)
                            .strokeBorder(Theme.primary, lineWidth: 1.5)
                    }
                }
        }
        .buttonStyle(.plain)
    }

    private var foregroundColor: Color {
        switch style {
        case .primary: Theme.cremaClaro
        case .secondary: Theme.primary
        case .text: Theme.primary
        }
    }

    private var backgroundColor: Color {
        switch style {
        case .primary: Theme.primary
        case .secondary: .clear
        case .text: .clear
        }
    }
}
