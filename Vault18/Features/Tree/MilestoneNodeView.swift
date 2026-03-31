import SwiftUI

struct MilestoneNodeView: View {
    let milestone: Milestone
    let isActive: Bool
    let onTap: () -> Void

    @State private var pulseScale: CGFloat = 1.0
    @State private var appeared = false

    private let nodeHeight: CGFloat = 36
    private let minNodeWidth: CGFloat = 44

    var body: some View {
        Button {
            if milestone.isAvailable {
                let impact = UIImpactFeedbackGenerator(style: .light)
                impact.impactOccurred()
                onTap()
            }
        } label: {
            ZStack {
                // Pulse ring for active milestone
                if isActive {
                    RoundedRectangle(cornerRadius: nodeHeight / 2)
                        .fill(Theme.primary.opacity(0.15))
                        .padding(-8)
                        .scaleEffect(pulseScale)
                }

                // Node shape
                RoundedRectangle(cornerRadius: nodeHeight / 2)
                    .fill(fillColor)
                    .overlay {
                        if !milestone.isFilled && milestone.isAvailable {
                            RoundedRectangle(cornerRadius: nodeHeight / 2)
                                .strokeBorder(Theme.natural, style: StrokeStyle(lineWidth: 2, dash: [4, 3]))
                        }
                    }

                // Label
                Text(milestone.shortLabel)
                    .font(Theme.rounded(.caption2, weight: .bold))
                    .foregroundStyle(labelColor)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                    .padding(.horizontal, 8)
            }
            .frame(minWidth: minNodeWidth, minHeight: nodeHeight)
            .fixedSize()
        }
        .buttonStyle(.plain)
        .disabled(!milestone.isAvailable)
        .opacity(milestone.isAvailable ? 1.0 : 0.3)
        .scaleEffect(appeared ? 1.0 : 0.6)
        .accessibilityLabel("\(milestone.title), \(milestone.isFilled ? "\(milestone.capsuleCount) recuerdos" : "vacío")")
        .accessibilityHint(milestone.isAvailable ? "Toca para ver este hito" : "Hito futuro, no disponible aún")
        .onAppear {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.65).delay(Double(milestone.sortOrder) * 0.03)) {
                appeared = true
            }
            if isActive {
                withAnimation(.easeInOut(duration: 1.8).repeatForever(autoreverses: true)) {
                    pulseScale = 1.12
                }
            }
        }
    }

    private var fillColor: Color {
        if milestone.isFilled { return Theme.primary }
        if milestone.isAvailable { return Theme.surface }
        return Theme.marronClaro.opacity(0.15)
    }

    private var labelColor: Color {
        if milestone.isFilled { return Theme.cremaClaro }
        if milestone.isAvailable { return Theme.textSecondary }
        return Theme.marronClaro.opacity(0.3)
    }
}
