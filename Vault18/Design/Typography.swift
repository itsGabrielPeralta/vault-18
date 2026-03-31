import SwiftUI

// MARK: - Text style modifiers

struct VaultTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Theme.titleLarge)
            .foregroundStyle(Theme.textPrimary)
    }
}

struct VaultHeadline: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Theme.titleMedium)
            .foregroundStyle(Theme.textPrimary)
    }
}

struct VaultSubheadline: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Theme.titleSmall)
            .foregroundStyle(Theme.textPrimary)
    }
}

struct VaultBody: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Theme.bodyFont)
            .foregroundStyle(Theme.textPrimary)
    }
}

struct VaultSecondary: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Theme.caption)
            .foregroundStyle(Theme.textSecondary)
    }
}

extension View {
    func vaultTitle() -> some View { modifier(VaultTitle()) }
    func vaultHeadline() -> some View { modifier(VaultHeadline()) }
    func vaultSubheadline() -> some View { modifier(VaultSubheadline()) }
    func vaultBody() -> some View { modifier(VaultBody()) }
    func vaultSecondary() -> some View { modifier(VaultSecondary()) }
}
