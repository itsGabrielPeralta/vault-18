import SwiftUI

struct EmptyStateView: View {
    let message: String
    var actionTitle: String?
    var action: (() -> Void)?

    var body: some View {
        VStack(spacing: Theme.spacingL) {
            // Small branch illustration
            BranchIllustration()
                .frame(width: 80, height: 80)

            Text(message)
                .font(Theme.bodyFont)
                .foregroundStyle(Theme.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, Theme.spacingXL)

            if let actionTitle, let action {
                VaultButton(title: actionTitle, style: .primary, action: action)
                    .padding(.horizontal, Theme.spacingXXL)
            }
        }
        .padding(.vertical, Theme.spacingXXL)
    }
}

// A small decorative bare branch
private struct BranchIllustration: View {
    var body: some View {
        Canvas { context, size in
            let mid = CGPoint(x: size.width / 2, y: size.height)

            // Main stem
            var stem = Path()
            stem.move(to: mid)
            stem.addQuadCurve(
                to: CGPoint(x: mid.x - 4, y: size.height * 0.2),
                control: CGPoint(x: mid.x + 6, y: size.height * 0.55)
            )
            context.stroke(stem, with: .color(Theme.natural.opacity(0.5)), lineWidth: 3)

            // Left branch
            var left = Path()
            left.move(to: CGPoint(x: mid.x - 1, y: size.height * 0.45))
            left.addQuadCurve(
                to: CGPoint(x: size.width * 0.15, y: size.height * 0.25),
                control: CGPoint(x: mid.x - 12, y: size.height * 0.32)
            )
            context.stroke(left, with: .color(Theme.natural.opacity(0.4)), lineWidth: 2)

            // Right branch
            var right = Path()
            right.move(to: CGPoint(x: mid.x + 1, y: size.height * 0.35))
            right.addQuadCurve(
                to: CGPoint(x: size.width * 0.8, y: size.height * 0.15),
                control: CGPoint(x: mid.x + 14, y: size.height * 0.2)
            )
            context.stroke(right, with: .color(Theme.natural.opacity(0.4)), lineWidth: 2)

            // Small bud at top
            let budCenter = CGPoint(x: mid.x - 4, y: size.height * 0.18)
            let budRect = CGRect(
                x: budCenter.x - 4,
                y: budCenter.y - 4,
                width: 8,
                height: 8
            )
            context.fill(Path(ellipseIn: budRect), with: .color(Theme.natural.opacity(0.3)))
        }
    }
}
