import SwiftUI

struct TreeCanvasView: View {
    let positions: [MilestonePosition]
    let containerWidth: CGFloat
    let totalHeight: CGFloat
    let activeMilestoneID: UUID?

    var body: some View {
        Canvas { context, size in
            let midX = size.width / 2

            // Ground at the bottom (where birth/roots are)
            drawGround(context: context, size: size)

            // Trunk connecting all nodes
            drawTrunk(context: context, midX: midX)

            // Branches from trunk to each node
            drawBranches(context: context)

            // Leaves around filled milestones
            drawLeaves(context: context)
        }
        .frame(width: containerWidth, height: totalHeight)
    }

    // MARK: - Ground

    private func drawGround(context: GraphicsContext, size: CGSize) {
        // Birth is at the bottom — ground is below birth
        guard let birthPos = positions.max(by: { $0.center.y < $1.center.y }) else { return }
        let groundY = birthPos.center.y + 25

        let ground = TreeLayout.groundPath(width: size.width, groundY: groundY)
        context.fill(ground, with: .color(Theme.chocolate.opacity(0.1)))
    }

    // MARK: - Trunk

    private func drawTrunk(context: GraphicsContext, midX: CGFloat) {
        guard !positions.isEmpty else { return }

        let trunkPath = TreeLayout.trunkPath(
            positions: positions,
            midX: midX,
            totalHeight: totalHeight
        )

        // Outer glow for organic feel
        context.stroke(
            trunkPath,
            with: .color(Theme.natural.opacity(0.25)),
            style: StrokeStyle(lineWidth: 12, lineCap: .round, lineJoin: .round)
        )

        // Main trunk
        context.stroke(
            trunkPath,
            with: .color(Theme.natural),
            style: StrokeStyle(lineWidth: 6.5, lineCap: .round, lineJoin: .round)
        )
    }

    // MARK: - Branches

    private func drawBranches(context: GraphicsContext) {
        for pos in positions {
            guard pos.side != .center else { continue }

            let path = TreeLayout.branchPath(
                from: pos.branchOrigin,
                to: pos.center,
                side: pos.side
            )

            let opacity: Double = pos.milestone.isAvailable ? 1.0 : 0.25

            context.stroke(
                path,
                with: .color(Theme.natural.opacity(opacity)),
                style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round)
            )
        }
    }

    // MARK: - Leaves

    private func drawLeaves(context: GraphicsContext) {
        for pos in positions {
            guard pos.milestone.isFilled else { continue }

            let leafCount = min(pos.milestone.capsuleCount + 2, 6)
            let leaves = TreeLayout.leafPositions(
                around: pos.center,
                count: leafCount,
                sortOrder: pos.milestone.sortOrder
            )

            for (leafCenter, rotation) in leaves {
                var leafPath = Path(ellipseIn: CGRect(x: -5, y: -3, width: 10, height: 6))
                let transform = CGAffineTransform(rotationAngle: rotation)
                    .concatenating(CGAffineTransform(translationX: leafCenter.x, y: leafCenter.y))
                leafPath = leafPath.applying(transform)

                let baseOpacity = 0.35 + Double(min(pos.milestone.capsuleCount, 4)) * 0.1
                context.fill(leafPath, with: .color(Theme.natural.opacity(baseOpacity)))
            }
        }
    }
}
