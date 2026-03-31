import SwiftUI

struct WelcomeStepView: View {
    let onContinue: () -> Void

    @State private var sproutScale: CGFloat = 0.3
    @State private var sproutOpacity: Double = 0

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            // Seed and sprout illustration
            SeedIllustration()
                .frame(width: 160, height: 200)
                .scaleEffect(sproutScale)
                .opacity(sproutOpacity)

            Spacer().frame(height: Theme.spacingXL)

            Text("Cada gran arbol\nempezó como una\npequeña semilla")
                .font(Theme.titleLarge)
                .foregroundStyle(Theme.textPrimary)
                .multilineTextAlignment(.center)
                .lineSpacing(4)

            Spacer().frame(height: Theme.spacingM)

            Text("Vault 18 guarda los recuerdos de tus hijos\nhasta que estén listos para recibirlos.")
                .font(Theme.bodyFont)
                .foregroundStyle(Theme.textSecondary)
                .multilineTextAlignment(.center)
                .lineSpacing(2)

            Spacer()

            VaultButton(title: "Plantar mi primera semilla", style: .primary, action: onContinue)
                .padding(.horizontal, Theme.spacingL)

            Spacer().frame(height: Theme.spacingXXL)
        }
        .onAppear {
            withAnimation(.spring(response: 0.8, dampingFraction: 0.6).delay(0.2)) {
                sproutScale = 1.0
                sproutOpacity = 1.0
            }
        }
    }
}

// MARK: - Seed illustration drawn with SwiftUI Canvas

private struct SeedIllustration: View {
    var body: some View {
        Canvas { context, size in
            let midX = size.width / 2
            let groundY = size.height * 0.75

            // Ground - gentle hill
            var ground = Path()
            ground.move(to: CGPoint(x: 0, y: groundY + 10))
            ground.addQuadCurve(
                to: CGPoint(x: size.width, y: groundY + 10),
                control: CGPoint(x: midX, y: groundY - 15)
            )
            ground.addLine(to: CGPoint(x: size.width, y: size.height))
            ground.addLine(to: CGPoint(x: 0, y: size.height))
            ground.closeSubpath()
            context.fill(ground, with: .color(Theme.chocolate.opacity(0.12)))

            // Stem
            var stem = Path()
            stem.move(to: CGPoint(x: midX, y: groundY - 5))
            stem.addQuadCurve(
                to: CGPoint(x: midX - 3, y: size.height * 0.28),
                control: CGPoint(x: midX + 8, y: size.height * 0.5)
            )
            context.stroke(stem, with: .color(Theme.natural), style: StrokeStyle(lineWidth: 3.5, lineCap: .round))

            // Left leaf
            let leafL = leafPath(
                base: CGPoint(x: midX - 2, y: size.height * 0.38),
                tip: CGPoint(x: midX - 30, y: size.height * 0.26),
                bulge: 14
            )
            context.fill(leafL, with: .color(Theme.natural.opacity(0.7)))

            // Right leaf
            let leafR = leafPath(
                base: CGPoint(x: midX + 1, y: size.height * 0.32),
                tip: CGPoint(x: midX + 28, y: size.height * 0.18),
                bulge: 14
            )
            context.fill(leafR, with: .color(Theme.natural.opacity(0.8)))

            // Top tiny leaf (unfurling)
            let leafTop = leafPath(
                base: CGPoint(x: midX - 3, y: size.height * 0.3),
                tip: CGPoint(x: midX - 8, y: size.height * 0.15),
                bulge: 8
            )
            context.fill(leafTop, with: .color(Theme.natural.opacity(0.6)))

            // Seed in ground
            let seedRect = CGRect(x: midX - 10, y: groundY - 2, width: 20, height: 14)
            context.fill(Path(ellipseIn: seedRect), with: .color(Theme.terracota.opacity(0.5)))
        }
    }

    private func leafPath(base: CGPoint, tip: CGPoint, bulge: CGFloat) -> Path {
        let dx = tip.x - base.x
        let dy = tip.y - base.y
        let len = sqrt(dx * dx + dy * dy)
        guard len > 0 else { return Path() }
        let nx = -dy / len * bulge
        let ny = dx / len * bulge

        let midPoint = CGPoint(x: (base.x + tip.x) / 2, y: (base.y + tip.y) / 2)
        let cp1 = CGPoint(x: midPoint.x + nx, y: midPoint.y + ny)
        let cp2 = CGPoint(x: midPoint.x - nx, y: midPoint.y - ny)

        var path = Path()
        path.move(to: base)
        path.addQuadCurve(to: tip, control: cp1)
        path.addQuadCurve(to: base, control: cp2)
        return path
    }
}
