import SwiftUI
import SwiftData

struct ContentView: View {
    @Query(sort: \Child.createdAt) private var children: [Child]
    @State private var selectedChild: Child?
    @State private var showingOnboarding = false

    var body: some View {
        Group {
            if children.isEmpty && !showingOnboarding {
                OnboardingView()
            } else if let child = selectedChild {
                TreeView(child: child, onBack: { selectedChild = nil })
            } else {
                childListView
            }
        }
        .background(Theme.background.ignoresSafeArea())
        .onChange(of: children.count) { oldCount, newCount in
            // When a new child is created via onboarding, select it
            if newCount > oldCount, let newest = children.last {
                selectedChild = newest
                showingOnboarding = false
            }
        }
    }

    // MARK: - Child list

    private var childListView: some View {
        ZStack {
            Theme.background.ignoresSafeArea()

            ScrollView {
                VStack(spacing: Theme.spacingL) {
                    Text("Tus semillas")
                        .font(Theme.titleLarge)
                        .foregroundStyle(Theme.textPrimary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, Theme.spacingXL)

                    ForEach(children, id: \.id) { child in
                        Button {
                            selectedChild = child
                        } label: {
                            childRow(child)
                        }
                        .buttonStyle(.plain)
                    }

                    // Add child button
                    Button {
                        showingOnboarding = true
                    } label: {
                        HStack(spacing: Theme.spacingS) {
                            Image(systemName: "plus.circle.fill")
                                .font(Theme.titleSmall)
                                .foregroundStyle(Theme.primary)
                            Text("Plantar otra semilla")
                                .font(Theme.bodyBold)
                                .foregroundStyle(Theme.primary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, Theme.spacingM)
                        .background(Theme.primary.opacity(0.08))
                        .clipShape(RoundedRectangle(cornerRadius: Theme.radiusM))
                    }
                    .buttonStyle(.plain)
                }
                .padding(.horizontal, Theme.spacingM)
            }
        }
        .sheet(isPresented: $showingOnboarding) {
            OnboardingView()
        }
    }

    private func childRow(_ child: Child) -> some View {
        VaultCard {
            HStack(spacing: Theme.spacingM) {
                // Tree icon
                Circle()
                    .fill(Theme.natural.opacity(0.15))
                    .frame(width: 48, height: 48)
                    .overlay {
                        Image(systemName: "leaf.fill")
                            .font(Theme.titleSmall)
                            .foregroundStyle(Theme.natural)
                    }

                VStack(alignment: .leading, spacing: Theme.spacingXS) {
                    Text(child.name)
                        .font(Theme.titleSmall)
                        .foregroundStyle(Theme.textPrimary)

                    Text(child.ageDescription)
                        .font(Theme.caption)
                        .foregroundStyle(Theme.textSecondary)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(Theme.caption)
                    .foregroundStyle(Theme.textSecondary)
            }
        }
    }
}
