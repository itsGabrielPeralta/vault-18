import SwiftUI

struct MilestonePosition {
    let milestone: Milestone
    let center: CGPoint       // Screen coordinates (Y down)
    let branchOrigin: CGPoint // Where branch meets the trunk
    let side: BranchSide

    enum BranchSide {
        case center, left, right
    }
}

enum TreeLayout {
    private static let earlySpacing: CGFloat = 90
    private static let yearSpacing: CGFloat = 130
    private static let topPadding: CGFloat = 100
    private static let bottomPadding: CGFloat = 120
    private static let branchLength: CGFloat = 85

    static func totalHeight(milestoneCount: Int) -> CGFloat {
        let earlyCount = min(milestoneCount, 4)
        let yearlyCount = max(milestoneCount - 4, 0)
        return topPadding + CGFloat(earlyCount) * earlySpacing + CGFloat(yearlyCount) * yearSpacing + bottomPadding
    }

    /// Computes positions in screen coordinates.
    /// Y=0 is the top of the canvas. Birth is at the bottom (large Y), future at the top (small Y).
    static func computePositions(
        milestones: [Milestone],
        containerWidth: CGFloat
    ) -> [MilestonePosition] {
        let sorted = milestones.sorted { $0.sortOrder < $1.sortOrder }
        let midX = containerWidth / 2
        let height = totalHeight(milestoneCount: sorted.count)
        var positions: [MilestonePosition] = []

        // Compute logical Y first (birth=0, grows upward)
        var logicalY: CGFloat = 0
        var logicalYs: [CGFloat] = []
        for (index, _) in sorted.enumerated() {
            let spacing: CGFloat = index < 4 ? earlySpacing : yearSpacing
            if index > 0 { logicalY += spacing }
            logicalYs.append(logicalY)
        }

        for (index, milestone) in sorted.enumerated() {
            // Convert: birth at bottom, future at top
            let screenY = height - bottomPadding - logicalYs[index]

            let side: MilestonePosition.BranchSide
            let nodeX: CGFloat

            if index == 0 {
                side = .center
                nodeX = midX
            } else if index % 2 == 1 {
                side = .right
                nodeX = midX + branchLength
            } else {
                side = .left
                nodeX = midX - branchLength
            }

            let trunkX = midX + wobbleOffset(for: milestone.sortOrder)
            let branchOrigin = CGPoint(x: trunkX, y: screenY)
            let center = CGPoint(x: nodeX, y: screenY)

            positions.append(MilestonePosition(
                milestone: milestone,
                center: center,
                branchOrigin: branchOrigin,
                side: side
            ))
        }

        return positions
    }

    static func wobbleOffset(for sortOrder: Int) -> CGFloat {
        let seed = Double(sortOrder * 7 + 3)
        return CGFloat(sin(seed) * 5)
    }

    // MARK: - Branch path (organic Bezier)

    static func branchPath(from origin: CGPoint, to nodeCenter: CGPoint, side: MilestonePosition.BranchSide) -> Path {
        guard side != .center else { return Path() }

        var path = Path()
        path.move(to: origin)

        let dx = nodeCenter.x - origin.x
        // Branches curve slightly upward (negative Y in screen coords) then out to node
        let cp1 = CGPoint(
            x: origin.x + dx * 0.15,
            y: origin.y - 14
        )
        let cp2 = CGPoint(
            x: origin.x + dx * 0.7,
            y: nodeCenter.y + 5
        )
        path.addCurve(to: nodeCenter, control1: cp1, control2: cp2)
        return path
    }

    // MARK: - Trunk path

    /// Draws trunk from the bottom (birth) upward through all positions.
    /// Positions must be in screen coords (birth has largest Y).
    static func trunkPath(positions: [MilestonePosition], midX: CGFloat, totalHeight: CGFloat) -> Path {
        // Sort by Y descending (birth first = largest Y)
        let sortedByY = positions.sorted { $0.branchOrigin.y > $1.branchOrigin.y }
        let trunkPoints = sortedByY.map { $0.branchOrigin }

        guard !trunkPoints.isEmpty else {
            var p = Path()
            p.move(to: CGPoint(x: midX, y: totalHeight))
            p.addLine(to: CGPoint(x: midX, y: 0))
            return p
        }

        var path = Path()

        // Start below the first (birth) node — the ground
        let groundY = trunkPoints[0].y + 40
        path.move(to: CGPoint(x: midX, y: groundY))

        // Connect through each trunk point
        for i in 0..<trunkPoints.count {
            let target = trunkPoints[i]
            if i == 0 {
                let cp = CGPoint(x: midX + 3, y: (groundY + target.y) / 2)
                path.addQuadCurve(to: target, control: cp)
            } else {
                let prev = trunkPoints[i - 1]
                let midY = (prev.y + target.y) / 2
                let w1 = wobbleOffset(for: i * 3 + 1) * 0.7
                let w2 = wobbleOffset(for: i * 5 + 2) * 0.7
                let cp1 = CGPoint(x: prev.x + w1, y: midY + abs(target.y - prev.y) * 0.15)
                let cp2 = CGPoint(x: target.x + w2, y: midY - abs(target.y - prev.y) * 0.15)
                path.addCurve(to: target, control1: cp1, control2: cp2)
            }
        }

        // Extend above the last node (tip of tree)
        if let last = trunkPoints.last {
            let tipY = last.y - 40
            path.addQuadCurve(
                to: CGPoint(x: midX - 2, y: tipY),
                control: CGPoint(x: last.x + 3, y: last.y - 20)
            )
        }

        return path
    }

    // MARK: - Ground shape

    static func groundPath(width: CGFloat, groundY: CGFloat) -> Path {
        var ground = Path()
        ground.move(to: CGPoint(x: 0, y: groundY))
        ground.addQuadCurve(
            to: CGPoint(x: width, y: groundY),
            control: CGPoint(x: width / 2, y: groundY - 20)
        )
        ground.addLine(to: CGPoint(x: width, y: groundY + 60))
        ground.addLine(to: CGPoint(x: 0, y: groundY + 60))
        ground.closeSubpath()
        return ground
    }

    // MARK: - Leaf decorations

    static func leafPositions(around center: CGPoint, count: Int, sortOrder: Int) -> [(CGPoint, Double)] {
        var leaves: [(CGPoint, Double)] = []
        for i in 0..<count {
            let seed = Double(sortOrder * 13 + i * 7)
            let angle = seed.truncatingRemainder(dividingBy: .pi * 2)
            let radius: CGFloat = 22 + CGFloat(sin(seed * 2.3)) * 6
            let x = center.x + cos(angle) * radius
            let y = center.y + sin(angle) * radius
            let rotation = angle + .pi / 4
            leaves.append((CGPoint(x: x, y: y), rotation))
        }
        return leaves
    }
}
