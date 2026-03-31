import SwiftUI
import SwiftData

struct TreeView: View {
    let child: Child
    let onBack: () -> Void
    @State private var vm: TreeViewModel
    @State private var navigationPath = NavigationPath()

    init(child: Child, onBack: @escaping () -> Void) {
        self.child = child
        self.onBack = onBack
        self._vm = State(initialValue: TreeViewModel(child: child))
    }

    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack {
                Theme.background.ignoresSafeArea()

                GeometryReader { geo in
                    let width = geo.size.width
                    let positions = TreeLayout.computePositions(
                        milestones: vm.sortedMilestones,
                        containerWidth: width
                    )
                    let totalHeight = TreeLayout.totalHeight(milestoneCount: vm.sortedMilestones.count)

                    ScrollViewReader { proxy in
                        ScrollView(.vertical, showsIndicators: false) {
                            ZStack {
                                // Canvas layer: trunk, branches, leaves, ground
                                TreeCanvasView(
                                    positions: positions,
                                    containerWidth: width,
                                    totalHeight: totalHeight,
                                    activeMilestoneID: vm.activeMilestoneID
                                )

                                // Node overlay layer
                                ForEach(positions, id: \.milestone.id) { pos in
                                    let isActive = pos.milestone.id == vm.activeMilestoneID
                                    MilestoneNodeView(
                                        milestone: pos.milestone,
                                        isActive: isActive,
                                        onTap: {
                                            guard pos.milestone.isAvailable else { return }
                                            navigationPath.append(
                                                AppDestination.milestoneDetail(milestoneID: pos.milestone.id)
                                            )
                                        }
                                    )
                                    .position(x: pos.center.x, y: pos.center.y)
                                    .id(pos.milestone.id)
                                }
                            }
                            .frame(width: width, height: totalHeight)
                        }
                        .onAppear {
                            if let activeID = vm.activeMilestoneID {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    withAnimation(.easeOut(duration: 0.5)) {
                                        proxy.scrollTo(activeID, anchor: .center)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .safeAreaInset(edge: .top) {
                treeHeader
            }
            .navigationDestination(for: AppDestination.self) { destination in
                switch destination {
                case .milestoneDetail(let milestoneID):
                    if let milestone = vm.sortedMilestones.first(where: { $0.id == milestoneID }) {
                        MilestoneDetailView(milestone: milestone, child: child)
                    }
                }
            }
        }
        .tint(Theme.primary)
    }

    // MARK: - Header

    private var treeHeader: some View {
        HStack {
            Button(action: onBack) {
                Image(systemName: "chevron.left")
                    .font(Theme.rounded(.body, weight: .semibold))
                    .foregroundStyle(Theme.textSecondary)
            }

            Spacer()

            VStack(spacing: Theme.spacingXS) {
                Text("El árbol de \(child.name)")
                    .font(Theme.titleMedium)
                    .foregroundStyle(Theme.textPrimary)

                Text(child.ageDescription)
                    .font(Theme.caption)
                    .foregroundStyle(Theme.textSecondary)
            }

            Spacer()

            // Balance the back button
            Color.clear.frame(width: 24, height: 24)
        }
        .padding(.horizontal, Theme.spacingM)
        .padding(.vertical, Theme.spacingM)
        .background(Theme.background.opacity(0.96))
    }
}
